FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.within(range: 150..212) }
    brew_time { Faker::Number.within(range: 30..300) }
  end
end
