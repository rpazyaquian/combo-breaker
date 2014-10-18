require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "#new" do
  end

  describe "#create" do
    context 'with valid information' do
      it "sets session user id to user's id" do
        user = FactoryGirl.create(:user)
        post :create, session: {
          email: user.email, password: user.password
        }
        expect(User.find(session[:user_id])).to eq user
      end
    end
  end

  describe "#destroy" do
    it "sets the session's user id to nil" do
    end
  end

end
