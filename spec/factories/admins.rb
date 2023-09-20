FactoryBot.define do
  factory :admin do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
    password { 'password' }
    password_confirmation { 'password' }


    trait :invalid do
      email { nil }
    end

    factory :empty_email, traits: %i[invalid]
  end
end
