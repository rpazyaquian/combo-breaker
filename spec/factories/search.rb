# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    search_params do
      street_address = Faker::Address.street_address
      city = Faker::Address.city
      state_abbr = Faker::Address.state_abbr
      location = 'Coolidge Corner, Brookline, MA'
      meals = []
      3.times do
        meals << Faker::Commerce.color
      end
      meals
      { location: location, meal_history: meals}
    end

    initialize_with do
      new(search_params)
    end
  end
end
