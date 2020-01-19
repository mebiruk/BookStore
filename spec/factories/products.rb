FactoryBot.define do
  factory :product do
    title {Faker::Book.title}
    publisher_name {Faker::Book.publisher}
    author_name {Faker::Book.author}
    price {Settings.factories.products.price}
    num_exist {Settings.factories.products.num_exist}
    remote_picture_url {Settings.factories.products.picture}
    description {Faker::Lorem.characters}
    association :category
  end
end
