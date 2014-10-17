class HomeController < ApplicationController
  def index
    combo_breaker_client = ComboBreakerClient.new
    @cuisine_options = combo_breaker_client.cuisine_options
  end
  def search
    combo_breaker_client = ComboBreakerClient.new
    results = combo_breaker_client.search(search_params(params))
    @businesses = results[:businesses]
    @cuisine = results[:cuisine]
  end

  private

    def search_params(params)
      {
        location: params[:location],
        cuisine: params[:cuisine].to_sym
      }
    end
end
