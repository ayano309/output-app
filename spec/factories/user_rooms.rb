FactoryBot.define do
  factory :user_room do
    association :user
    association :room
  end
end
