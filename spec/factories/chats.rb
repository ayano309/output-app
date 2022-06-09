FactoryBot.define do
  factory :chat do
    user { nil }
    room { nil }
    message { 'MyString' }
  end
end
