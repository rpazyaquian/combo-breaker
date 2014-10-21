require 'rails_helper'

RSpec.describe Search, :type => :model do

  before(:all) do
    @user = FactoryGirl.create(:user)
    5.times do
      meal = FactoryGirl.create(:meal, cuisine: 'italian')
      @user.meals << meal
    end
  end

  it "has a valid factory" do
    search = FactoryGirl.create(:search)
    expect(search).to be_valid
  end

  it "takes a location and a user's meal history" do
    search = FactoryGirl.create(:search,
      location: 'Coolidge Corner, Brookline, MA',
      meal_history: @user.meal_history
      )
    expect(search).to be_valid
  end

  describe "#search" do

    before(:all) do
      @search = FactoryGirl.create(:search,
        location: 'Coolidge Corner, Brookline, MA',
        meal_history: @user.meal_history
      )
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