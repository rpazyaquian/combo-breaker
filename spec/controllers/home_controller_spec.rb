require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "#search" do
    :post, search_form: {
      location: 'Coolidge Corner, Brookline, MA',
      cuisine: :burgers,
      radius_distance: 1,
      radius_units: :mi
    }
    expect(response.status).to eq(200)
  end
end
