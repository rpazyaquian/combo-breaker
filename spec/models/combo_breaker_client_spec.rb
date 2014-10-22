require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = ComboBreakerClient.new
    @params = {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: :chinese,
      }
<<<<<<< HEAD
    @results = @combo_breaker_client.search(@params[:location], @params[:radius], @params[:cuisine])
=======
    @results = @combo_breaker_client.search_api(@params)
>>>>>>> google_places
  end

  it "returns a BurstStructure thing" do
    # an array of hashes
<<<<<<< HEAD
    expect(@results.businesses).to be_a(Array)
=======
    expect(@results).to be_a(BurstStruct::Burst)
>>>>>>> google_places
  end

end
