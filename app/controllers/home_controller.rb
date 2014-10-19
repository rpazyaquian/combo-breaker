class HomeController < ApplicationController
  def index
    # don't you dare say anything
    @cuisine_options = [
      ["Italian", "italian"],
      ["Breakfast & Brunch", "breakfast_brunch"],
      ["Delis", "delis"],
      ["Burgers", "burgers"],
      ["Mexican", "mexican"],
      ["Gluten-Free", "gluten_free"],
      ["Middle Eastern", "mideastern"],
      ["Kosher", "kosher"],
      ["Sushi Bars", "sushi"],
      ["Japanese", "japanese"],
      ["Bars", "bars"],
      ["American (New)", "newamerican"],
      ["Sandwiches", "sandwiches"],
      ["Bagels", "bagels"],
      ["Thai", "thai"],
      ["Indian", "indpak"],
      ["Vegetarian", "vegetarian"],
      ["Vegan", "vegan"],
      ["Vietnamese", "vietnamese"],
      ["Sports Bars", "sportsbars"],
      ["American (Traditional)", "tradamerican"],
      ["Specialty Food", "gourmet"],
      ["Seafood", "seafood"],
      ["Korean", "korean"],
      ["Cafes", "cafes"],
      ["Creperies", "creperies"],
      ["Pizza", "pizza"]
    ]
    @distance_units = [
      :km,
      :mi
    ]
  end

  def search
    results = search(search_params)
    @businesses = results
  end

  private

    def search(params)
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

    def choose_cuisine(businesses, cuisines)
      cuisine = cuisines.sample
      filtered_businesses = businesses.find_all { |business|
        business.categories.include?(cuisine)
      }
      [filtered_businesses, cuisine]
    end

    def meters(distance, units)
      Unit("#{distance} #{units}").convert_to('m').scalar
    end

end
