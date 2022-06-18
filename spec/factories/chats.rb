FactoryBot.define do
  factory :chat do
    association :user
    association :room
    message { Faker::Lorem.characters(number: 20) }
  end
end
