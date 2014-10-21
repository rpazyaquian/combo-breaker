require 'rails_helper'

RSpec.describe Search, :type => :model do
  it "has a valid factory" do
    search = FactoryGirl.build(:search)
    expect(search).to be_valid
  end
  it "takes a location and the last-eaten cuisine" do
    search = FactoryGirl.build(:search,
      location: 'Coolidge Corner, Brookline, MA',
      cuisine: 'pizza'
      )
    expect(search).to be_valid
  end

  describe "#search" do

    before(:each) do
      @search = FactoryGirl.build(:search,
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: 'pizza'
      )
    end

    it "returns a chosen cuisine that is not the last eaten cuisine" do
      expect(@search.cuisine).not_to eq 'pizza'
    end

    it "returns a list of businesses" do
      expect(@search.businesses).to be_an(Array)
    end

  end
end