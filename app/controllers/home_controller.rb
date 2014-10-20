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
    # this looks way too convoluted.
    # grab results from local area
    # get list of categories from local area
    # filter out cafes, bars, etc. and the last-eaten cuisine
    # choose a random cuisine from what's left
    # grab results filtered by that cuisine.

    # grab results from local area
    results = search_api(search_params)

    # get list of categories from local area
    cuisines = get_categories(results)

    # filter out cafes, bars, etc. and the last-eaten cuisine

    filtered_cuisines = filter_cuisines(cuisines)

    # choose a random cuisine from what's left

    random_cuisine = filtered_cuisines.to_a.sample

    @cuisine = random_cuisine[0]
    search_cuisine = random_cuisine[1]

    # grab results filtered by that cuisine.
    filtered_results = search_api(search_params, search_cuisine)

    @businesses = filtered_results

    # filtered_results = filter_results(results, last_cuisine)
    # @businesses = filtered_results[:businesses]
    # @cuisine = filtered_results[:cuisine]
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
