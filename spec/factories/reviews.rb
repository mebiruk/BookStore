FactoryBot.define do
  factory :review do
    content {Faker::Lorem.word}
    rate {Settings.factories.reviews.rate}
    association :product
    association :user
  end
end
