FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 300) }
    subcontent { Faker::Lorem.characters(number: 100) }
  end
end
