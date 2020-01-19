FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    address { Faker::Address.city }
    phone { Faker::PhoneNumber
      .subscriber_number(length: Settings.factories.users.phone_length) }
    password { Faker::Lorem.characters(number: Settings.factories.users.pass_length)}
    role { Settings.factories.users.default_role }
  end
end
