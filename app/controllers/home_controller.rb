class HomeController < ApplicationController
  def index
  end
  def search
    combo_breaker_client = ComboBreakerClient.new
    results = combo_breaker_client.search(search_params(params))
    @businesses = results.businesses
    @cuisines = results.cuisines
  end

  private

    def search_params(params)
      {
        location: params[:location],
        cuisine: params[:cuisine].to_sym
      }
    end
end
