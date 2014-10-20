require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    expect(user).to be_valid
  end

  it "is invalid when no password is supplied" do
    user = FactoryGirl.build(:user, password: '')
    expect(user).not_to be_valid
  end

  it "is invalid when password and password confirmaton do not match" do
    user = FactoryGirl.build(:user, password_confirmation: 'thisisdefinitelynotamatchingpasswordright')
    expect(user).not_to be_valid
  end

  it "is invalid when email is not supplied" do
    user = FactoryGirl.build(:user, email: '')
    expect(user).not_to be_valid
  end

  it "is invalid when user name is not supplied" do
    user = FactoryGirl.build(:user, name: '')
    expect(user).not_to be_valid
  end

  it "is valid with email, name, password, and password_confirmation" do
    user = FactoryGirl.create(:user)
    expect(user).to be_valid
  end

  describe "meal history" do
    it "takes a maximum of ten meals" do
      user.FactoryGirl.create(:user)
      11.times do
        user.meals.create(cuisine: :italian)
      end
      expect(user.meals.count).to eq 10
    end
    it "removes the oldest meal" do
      user.FactoryGirl.create(:user)
      oldest_meal = user.meals.create(cuisine: :indian)
      10.times do
        user.meals.create(cuisine: :italian)
      end
      expect(user.meals).not_to include(oldest_meal)
    end
  end
end
