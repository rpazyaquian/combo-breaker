# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    display_name do
      Faker::Commerce.product_name
    end
    search_value do
      Faker::Commerce.color
    end
  end
end
