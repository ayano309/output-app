FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    user { nil }
    book { nil }
  end
end
