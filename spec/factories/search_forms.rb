# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_form do
    location "MyString"
    cuisine "MyString"
    radius_distance 1
    radius_units "MyString"
  end
end
