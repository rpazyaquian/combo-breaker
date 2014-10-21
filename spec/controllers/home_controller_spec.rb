require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "#search" do
    it "should return a 200 response" do
      post :search, search_form: {
        location: 'Coolidge Corner, Brookline, MA',
        cuisine: 'burgers'
      }
      expect(response.status).to eq(200)
    it "should redirect to "
    end
  end
end
