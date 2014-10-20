# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal do
    cuisine { Faker::Commerce.color }
    user nil
  end
end
