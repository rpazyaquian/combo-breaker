require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = ComboBreakerClient.new
    @params =       {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: :chinese,
        radius: 10000
      }
    @results = @combo_breaker_client.search(@params)
  end

  it "returns a list of businesses in the area" do
    # an array of hashes
    expect(@results).to be_a(Array)
  end

end
