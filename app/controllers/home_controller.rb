class HomeController < ApplicationController
  def index
  end
  def search
    combo_breaker_client = ComboBreakerClient.new
    combo_breaker_client.search(search_params(params))
    @businesses, @cuisine = choose_cuisine(combo_breaker_client.businesses, combo_breaker_client.cuisines)
  end

  private

    def search_params(params)
      {
        location: params[:location],
        cuisine: params[:cuisine].to_sym
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
