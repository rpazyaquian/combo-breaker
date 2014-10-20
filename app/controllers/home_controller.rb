class HomeController < ApplicationController

  include HomeHelper

  def index
    @cuisine_options = Category.all_categories.sort_by { |category| category[0] }
    @distance_units = [
      :mi,
      :km
    ]
  end

  def search
    # results = search_api(search_params)
    # cuisines = get_categories(results)
    # filtered_cuisines = filter_cuisines(cuisines)
    # random_cuisine = filtered_cuisines.to_a.sample
    # @cuisine = random_cuisine[0]
    # search_cuisine = random_cuisine[1]
    # filtered_results = search_api(search_params, search_cuisine)
    # @businesses = filtered_results
    results = search(search_params)
    @businesses = results.businesses
    @cuisine = results.cuisine
  end

  private

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
