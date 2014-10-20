require 'rails_helper'

RSpec.describe Location, :type => :model do
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
      location << category
    end

    expect(location.categories.count).to eq 2
  end
end
