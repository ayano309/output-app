FactoryBot.define do
  factory :group do
    association :user
    name { Faker::Lorem.characters(number: 5) }
    introduction { Faker::Lorem.characters(number: 20) }
  end
end
