FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email(domain: 'foo.com') }
    credibility { 19.2 }
    admin { association :admin }
    password { 'password' }
    password_confirmation { 'password' }

    trait :invalid do
      email { nil }
    end

    factory :empty_user_email, traits: [:invalid]
  end
end
