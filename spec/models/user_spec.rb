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
end
