require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = ComboBreakerClient.new
    @location = 'Coolidge Corner, Brookline, MA'
    @cuisine = :italian
    @params = {
      location: @location,
      cuisine: @cuisine
    }
    @results = @combo_breaker_client.search(@params)
  end

  it "returns a list of available cuisines" do
    results = ComboBreakerClient.search('Coolidge Corner, Brookline, MA', { term: 'restaurant'} )
    @combo_breaker_client.get_available_cuisines(results)
  end

end
