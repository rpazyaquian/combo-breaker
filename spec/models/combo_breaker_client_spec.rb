require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = ComboBreakerClient.new
    @params = {
      location: 'Coolidge Corner, Brookline, MA',
    }
    @results = @combo_breaker_client.search(@params)
  end

  it "returns a list of businesses in the area" do
    # an array of hashes
    expect(@results.businesses).to be_a(Array)
  end

  it "returns all cuisines of those businesses" do
    # an array of arrays
    expect(@results.cuisines).to be_a(Array)
  end

  # i think i'll do the filtering somewhere else.

end
