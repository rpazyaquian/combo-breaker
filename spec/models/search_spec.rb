require 'rails_helper'

RSpec.describe Search, :type => :model do
<<<<<<< HEAD
  it "has a valid factory" do
    search = FactoryGirl.build(:search)
    expect(search).to be_valid
  end
  it "takes a location and the last-eaten cuisine" do
=======

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
>>>>>>> google_places
    search = FactoryGirl.build(:search,
      location: 'Coolidge Corner, Brookline, MA',
      meal_history: @user.meal_history
      )
    expect(search.meal_history).to eq @user.meal_history
  end

  describe "#search" do

<<<<<<< HEAD
    before(:each) do
=======
    before(:all) do
>>>>>>> google_places
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

    it "returns a list of businesses with that cuisine" do
      full_cuisine = Category.where(search_value: @search.cuisine).first.full_name
      business = @search.businesses.sample
      expect(business.categories).to include(full_cuisine)
    end

  end
end