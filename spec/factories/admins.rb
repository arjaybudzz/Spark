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

    factory :admin_sample do
      first_name { 'John' }
      middle_name { 'Sample' }
      last_name { 'Doe' }
      email { 'johndoe@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    trait :valid do
      email { 'johndoe@gmail.com' }
      password { 'password' }
    end

    trait :invalid_login do
      password { 'wrong password' }
    end

    factory :empty_email, traits: %i[invalid]
    factory :valid_login, traits: %i[valid]
    factory :wrong_password, traits: %i[invalid_login]
  end
end
