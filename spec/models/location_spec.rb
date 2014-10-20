require 'rails_helper'

RSpec.describe Location, :type => :model do

  # NOTE: think about how to force proper address
  # formatting, storage, etc.
  # this might be a problem!

  it "has a valid factory" do
    location = FactoryGirl.create(:location)
    expect(location).to be_valid
  end
  it "is invalid without an address" do
    location = FactoryGirl.build(:location, address: "")
    expect(location).not_to be_valid
  end
  it "has many categories" do
    location = FactoryGirl.create(:location)
    category1 = FactoryGirl.create(:category)
    category2 = FactoryGirl.create(:category)
    [category1, category2].each do |category|
      location.categories << category
    end

    expect(location.categories).to include(category1, category2)
  end
end
