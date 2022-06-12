FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number: 300) }
    user { nil }
    book { nil }
  end
end
