class HomeController < ApplicationController
  def index
    # don't you dare say anything
    @cuisine_options = [
      ["Italian", "italian"],
      ["Burgers", "burgers"],
      ["Mexican", "mexican"],
      ["Middle Eastern", "mideastern"],
      ["Sushi Bars", "sushi"],
      ["Japanese", "japanese"],
      ["American (New)", "newamerican"],
      ["Sandwiches", "sandwiches"],
      ["Bagels", "bagels"],
      ["Thai", "thai"],
      ["Indian", "indpak"],
      ["Vietnamese", "vietnamese"],
      ["American (Traditional)", "tradamerican"],
      ["Seafood", "seafood"],
      ["Korean", "korean"],
      ["Creperies", "creperies"],
      ["Pizza", "pizza"]
    ]
    @distance_units = [
      :km,
      :mi
    ]
  end

  def search
    results = search_api(search_params)
    filtered_results = filter_results(results, last_cuisine)
    @businesses = filtered_results[:businesses]
    @cuisine = filtered_results[:cuisine]
  end

  private

  # TODO: move search-specific methods to own module

    def filter_results(results, cuisine)

      businesses = process_results(results)[:businesses]
      cuisines = process_results(results)[:cuisines]

      cuisines.delete(cuisine)

      chosen_cuisine = cuisines.sample

      filtered_businesses = filter_businesses(businesses, chosen_cuisine)

      {
        businesses: filtered_businesses,
        cuisine: chosen_cuisine[0]
      }
    end

    def filter_businesses(businesses, cuisine)
      businesses.select do |business|
        business.categories.include?(cuisine)
      end
    end

    def process_results(results)

      mapped_results =  results.map do |business|
        { business: business, categories: business.categories }
      end

      businesses = mapped_results.map do |business|
        business[:business]
      end

      # since it's a set, there will be no repeats
      cuisines = Set.new

      mapped_results.each do |business|
        business[:categories].each do |cuisine|
          cuisines << cuisine
        end
      end

      {
        businesses: businesses,
        cuisines: cuisines.to_a
      }
    end

    def search_api(params)
      combo_breaker_client = ComboBreakerClient.new
      combo_breaker_client.search(params)
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
