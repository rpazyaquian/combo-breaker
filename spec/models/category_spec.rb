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
  it "belongs to many locations" do
    category = FactoryGirl.create(:category)
    location1 = FactoryGirl.create(:location)
    location2 = FactoryGirl.create(:location)

    [location1, location2].each do |location|
      location << category
    end

    expect(category.locations.count).to eq 2
  end
  it "must have a unique search value" do
    category1 = FactoryGirl.create(:category, search_value: 'unique')
    category2 = FactoryGirl.build(:category, search_value: 'unique')

    expect(category2).not_to be_valid
  end
  it "outputs a list of all categories" do
    category1 = FactoryGirl.create(:category)
    category2 = FactoryGirl.create(:category)
    expect(Category.all_categories).to include([
        category1.display_name,
        category1.search_value.to_sym
      ],[
        category2.display_name,
        category2.search_value.to_sym
      ])
  end
end
