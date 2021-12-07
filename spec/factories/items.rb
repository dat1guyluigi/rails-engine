FactoryBot.define do
  factory :item do
    name { Faker::Appliance.brand }
    description { Faker::Lorem.words }
    unit_price { Faker::Number.within(range: 1.0..10.0)}
  end
end
