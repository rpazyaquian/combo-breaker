# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    location do
      street_address = Faker::Address.street_address
      city = Faker::Address.city
      state_abbr = Faker::Address.state_abbr
      "#{street_address}, #{city}, #{state_abbr}"
    end
    meal_history do
      meals = []
      3.times do
        meals << Faker::Commerce.color
      end
      meals
    end

    initialize_with do
      new(location, meal_history)
    end
  end
end
