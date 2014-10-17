class HomeController < ApplicationController
  def index
    combo_breaker_client = ComboBreakerClient.new
    results = combo_breaker_client.search('Coolidge Corner, Brookline, MA')
    @businesses = results[:businesses]
    @category = results[:category]
  end
end
