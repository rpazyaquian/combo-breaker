require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:each) do
    @combo_breaker_client = ComboBreakerClient.new
    @location = 'Coolidge Corner, Brookline, MA'
    @cuisine = :italian
    @params = {
      location: @location,
      cuisine: @cuisine
    }
    @results = @combo_breaker_client.search(@params)
  end

  it "returns a random cuisine" do
    expect(@results[:cuisine]).to be_a(String)
  end
  it "returns a list of restaurants in given cuisine" do
    expect(@results[:businesses]).to be_a(Array)
  end
end
