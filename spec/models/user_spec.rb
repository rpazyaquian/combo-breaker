require 'rails_helper'

RSpec.describe User, :type => :model do
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
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end
end
