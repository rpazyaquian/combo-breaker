# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name  { Faker::Internet.user_name }
    password { Faker::Internet.password(8) }
    password_confirmation { "#{password}" }
  end
end
