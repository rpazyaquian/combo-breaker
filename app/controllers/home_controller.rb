class HomeController < ApplicationController
  def index
    combo_breaker_client = ComboBreakerClient.new
    params = {
      location: 'Coolidge Corner, Brookline, MA',
      cuisine: :italian
    }
    results = combo_breaker_client.search(params)
    @businesses = results[:businesses]
    @cuisine = results[:cuisine]
  end
  def search
    combo_breaker_client = ComboBreakerClient.new
    params = {
      location: 'Coolidge Corner, Brookline, MA',
      cuisine: :italian
    }
    results = combo_breaker_client.search(params)
    @businesses = results[:businesses]
    @cuisine = results[:cuisine]
  end
end
