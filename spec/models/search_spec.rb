require 'rails_helper'

RSpec.describe Search, :type => :model do

  before(:all) do
    @user = FactoryGirl.create(:user)
    5.times do
      @user.meals.create(cuisine: 'italian')
    end
    Category.create(display_name: 'Italian', search_value: 'italian')
    Category.create(display_name: 'Indian', search_value: 'indpak')
    Category.create(display_name: 'Chinese', search_value: 'chinese')
    Category.create(display_name: 'Japanese', search_value: 'japanese')
    Category.create(display_name: 'Mexican', search_value: 'mexican')
    Category.create(display_name: 'Thai', search_value: 'thai')
    Category.create(display_name: 'Seafood', search_value: 'seafood')
    Category.create(display_name: 'Pizza', search_value: 'pizza')
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
      # can't return a blank cuisine
      expect(@search.cuisine).to be_truthy
    end

    it "returns a chosen cuisine that is not in the meal history" do
      expect(@search.meal_history).not_to include(@search.cuisine)
    end

  end
end