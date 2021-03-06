require 'rails_helper'

RSpec.describe Meal, :type => :model do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  # ...is this how i should be testing it?

  it "is invalid without a given cuisine" do
    meal = @user.meals.create(cuisine: '')
    expect(meal).not_to be_valid
  end
end
