require 'rails_helper'

RSpec.describe SearchForm, :type => :model do
  it "has a valid factory" do
    search_form = FactoryGirl.build(:search_form)
    expect(search_form).to be_valid
  end
  it "is invalid without a location" do
    search_form = FactoryGirl.build(:search_form, location: '')
    expect(search_form).not_to be_valid
  end
  it "is invalid without a last eaten cuisine" do
    search_form = FactoryGirl.build(:search_form, cuisine: nil)
    expect(search_form).not_to be_valid
  end
  it "is invalid without a radius distance" do
    search_form = FactoryGirl.build(:search_form, radius_distance: nil)
    expect(search_form).not_to be_valid
  end
  it "is invalid without a radius unit" do
    search_form = FactoryGirl.build(:search_form, radius_units: nil)
    expect(search_form).not_to be_valid
  end
  it "is invalid with a radius greater than 40000m" do
    search_form = FactoryGirl.build(:search_form, radius_distance: 30, radius_units: :mi)
    expect(search_form).not_to be_valid
  end
end
