require 'rails_helper'

RSpec.describe ComboBreakerClient, :type => :model do

  before(:all) do
    @combo_breaker_client = FactoryGirl.build(:combo_breaker_client)
    @params =       {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: :chinese,
      }
    @combo_breaker_client.search_api(@params)
    @businesses = @combo_breaker_client.businesses
  end

  it "has an array of Businesses" do
    @businesses.each do |business|
      expect(business).to be_a(Business)
    end
  end


end
