require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = ComboBreakerClient.new
    @params =       {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: :chinese,
      }
    @results = @combo_breaker_client.search_api(@params)
  end

  it "returns a BurstStructure thing" do
    # an array of hashes
    expect(@results).to be_a(BurstStruct::Burst)
  end

end
