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
end
