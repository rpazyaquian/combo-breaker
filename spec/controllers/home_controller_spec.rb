require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  it "converts kilometers and miles to meters" do
    post :search, search: {
      location: 'Coolidge Corner, Brookline, MA',
      cuisine: :seafood,
      radius_distance: 2,
      radius_units: :km
    }
    expect(@radius).to eq Unit('2000 m')
  end
end
