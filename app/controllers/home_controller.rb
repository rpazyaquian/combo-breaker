class HomeController < ApplicationController
  def index
    @cuisine_options = Category.all_categories.sort_by { |category| category[0] }
    @distance_units = [
      :mi,
      :km
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

          unless (blacklist_categories(category) || Category.all_categories.include?(category))
            Category.create(
              display_name: category[0],
              search_value: category[1]
              )
          end

          categories << category
        end
      end
      categories
    end

    def blacklist_categories(category)
      blacklist = [
        ['Lounges', 'lounges'],
        ['Bars', 'bars'],

      ]
    end

    def filter_cuisines(cuisines)
      cuisines.delete_if do |cuisine|
        blacklist(cuisine)
      end
    end

    def blacklist(cuisine)
      blacklist = [
        last_cuisine.to_s
      ]
      blacklist.include?(cuisine)
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
