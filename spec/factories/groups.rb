FactoryBot.define do
  factory :group do
    association :user
    name { Faker::Lorem.characters(number: 30) }
    introduction { Faker::Lorem.characters(number: 100) }
  end
end
