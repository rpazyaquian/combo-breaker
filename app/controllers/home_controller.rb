class HomeController < ApplicationController
  def index
    # don't you dare say anything
    @cuisines = Category.all_categories
    @distance_units = [
      :km,
      :mi
    ]
  end

  def search
    results = search_api(search_params)

    cuisines = get_categories(results)

    filtered_cuisines = filter_cuisines(cuisines)

    random_cuisine = filtered_cuisines.to_a.sample

    @cuisine = random_cuisine[0]
    search_cuisine = random_cuisine[1]

    filtered_results = search_api(search_params, search_cuisine)

    @businesses = filtered_results
  end

  private

  # TODO: move search-specific methods to own module

    def get_categories(businesses)
      categories = Set.new
      businesses.each do |business|
        business.categories.each do |category|
          categories << category
        end
      end
      categories
    end

    def filter_cuisines(cuisines)
      cuisines.delete_if do |cuisine|
        cuisine[1] == last_cuisine.to_s
      end
    end

    def search_api(params, cuisine = '')
      combo_breaker_client = ComboBreakerClient.new
      combo_breaker_client.search(params, cuisine)
    end

    def search_params
      {
        location: params[:location],
        radius: meters(params[:radius_distance], params[:radius_units].to_sym)
      }
    end

    def last_cuisine
      params[:cuisine].to_sym
    end

    def meters(distance, units)
      Unit("#{distance} #{units}").convert_to('m').scalar
    end

end
