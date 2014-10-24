FactoryGirl.define do
  factory :api_client do
    api_code { ['yelp', 'places'].sample }
  end
end