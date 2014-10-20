require 'rails_helper'

RSpec.describe Category, :type => :model do
  it "has a valid factory" do
    category = FactoryGirl.create(:category)
    expect(category).to be_valid
  end
  it "is invalid without a display name" do
    category = FactoryGirl.build(:category, display_name: "")
    expect(category).not_to be_valid
  end
  it "is invalid without a search value" do
    category = FactoryGirl.build(:category, search_value: "")
    expect(category).not_to be_valid
  end
end
