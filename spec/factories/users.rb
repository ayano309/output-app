FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :with_profile do
      after :build do |user|
          build(:profile, user: user)
      end
    end
  end
end
