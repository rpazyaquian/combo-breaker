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
    combo_breaker_client = ComboBreakerClient.new
    begin
      combo_breaker_client.search(search_params(params))
      @businesses, @cuisine = choose_cuisine(combo_breaker_client.businesses, combo_breaker_client.cuisines)
    rescue ComboBreakerClient::LocationNotFound => e
      redirect_to root_path, :flash => { :error => e.message }
    end
  end

  private

    def search_params(params)
      {
        location: params[:location],
        cuisine: params[:cuisine].to_sym,
        radius_filter: params[:radius_filter]
      }
    end

    def choose_cuisine(businesses, cuisines)
      cuisine = cuisines.sample
      filtered_businesses = businesses.find_all { |business|
        business.categories.include?(cuisine)
      }
      [filtered_businesses, cuisine]
    end
end
