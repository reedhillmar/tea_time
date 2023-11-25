FactoryBot.define do
  factory :subscription_tea do
    subscription { nil }
    tea { nil }
    quantity { Faker::Number.within(1..10) }
  end
end
