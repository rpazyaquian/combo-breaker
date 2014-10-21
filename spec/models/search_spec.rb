require 'rails_helper'

RSpec.describe Search, :type => :model do

  before(:all) do
    @user = FactoryGirl.create(:user)
    5.times do
      @user.meals.create(cuisine: 'italian')
    end
  end

  it "takes a location and a user's meal history" do
    search = FactoryGirl.build(:search,
      location: 'Coolidge Corner, Brookline, MA',
      meal_history: @user.meal_history
      )
    expect(search.meal_history).to eq @user.meal_history
  end

  describe "#search" do

    before(:all) do
      @search = FactoryGirl.build(:search,
        location: 'Coolidge Corner, Brookline, MA',
        meal_history: @user.meal_history
      )
    end

    it "returns a random cuisine choice" do
      # can't have a blank cuisine return
      expect(@search.cuisine).to be_truthy
    end

    it "returns a chosen cuisine that is not in the meal history" do
      expect(@search.meal_history).not_to include(@search.cuisine)
    end

    it "returns a list of businesses with that cuisine" do
      business = @search.businesses.sample
      expect(business.categories).to include(@search.cuisine)
    end

  end
end