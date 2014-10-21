require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.meals.create(cuisine: :italian)
    @search_form = {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: 'burgers',
        radius_distance: 1,
        radius_units: 'mi'
      }
  end

  describe "#search" do
    it "adds the most recent cuisine to the user's history" do
      post :search, search_form: @search_form

      expect(@user.meal_history.last).to eq @search_form[:cuisine]
    end
  end
end
