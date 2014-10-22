require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
<<<<<<< HEAD

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.meals.create(cuisine: :italian)
    @search_form = {
=======
  describe "#search" do

    before(:all) do
      @user = FactoryGirl.create(:user)

      5.times do
        @user.meals.create(cuisine: :italian)
      end

      @search_form = {
>>>>>>> google_places
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: 'pizza'
      }
<<<<<<< HEAD
  end

  describe "#search" do
    it "adds the most recent cuisine to the user's history" do
      post :search, search_form: @search_form

      expect(@user.meal_history.last).to eq @search_form[:cuisine]
=======

      @invalid_search_form = {
        location: '',
        cuisine: 'pizza'
      }
    end

    context "with an invalid form" do

      it "does not add the cuisine type to the user's history" do
        post :search, { search_form: @invalid_search_form }, { user_id: @user.id }
        expect(@user.meal_history).not_to include('pizza')
      end
      it "redirects to the root page" do
        post :search, { search_form: @invalid_search_form }, { user_id: @user.id }
        expect(response).to redirect_to(root_path)
      end

    end

    context "with a valid form" do

      it "adds the cuisine type to the user's history" do
        post :search, { search_form: @search_form }, { user_id: @user.id }
        @user = User.find(@user.id)
        expect(@user.meal_history).to include('pizza')
      end
      it "assigns businesses to @businesses" do
        post :search, { search_form: @search_form }, { user_id: @user.id }
        expect(assigns(:businesses)).not_to be_nil
      end
      it "assigns a cuisine to @cuisine" do
        post :search, { search_form: @search_form }, { user_id: @user.id }
        expect(assigns(:cuisine)).not_to be_nil
      end

>>>>>>> google_places
    end
  end
end
