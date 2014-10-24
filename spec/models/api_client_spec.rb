require 'rails_helper'

RSpec.describe APIClient, :type => :model do

  it "has a valid factory" do
    api_client = FactoryGirl.build(:api_client)
    expect(api_client).to be_valid
  end

  it "takes an API's name" do
    api_client = FactoryGirl.build(:api_client, api: 'yelp')
    expect(api_client.api_type).to eq 'yelp'
  end

end