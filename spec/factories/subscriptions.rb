FactoryBot.define do
  factory :subscription do
    title { Faker::Lorem.word }
    price { Faker::Number.within(range: 1000..10000) }
    status { Faker::Number.within(range: 0..1) }
    frequency { Faker::Number.within(range: 0..2) }
  end
end
