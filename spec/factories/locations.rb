# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    address do
      street_address = Faker::Address.street_address
      city = Faker::Address.city
      state_abbr = Faker::Address.state_abbr
      "#{street_address}, #{city}, #{state_abbr}"
    end
  end
end
