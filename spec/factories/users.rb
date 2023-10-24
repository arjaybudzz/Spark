FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email(domain: 'gmail.com') }
    credibility { 19.2 }
    password { 'password' }
    password_confirmation { 'password' }

    trait :invalid do
      email { nil }
    end

    factory :user_sample do
      first_name { 'John' }
      middle_name { 'User' }
      last_name { 'Doe' }
      email { 'johndoe@gmail.com' }
      credibility { 19.2 }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :login do
      email { 'johndoe@gmail.com' }
      password { 'password' }
    end

    factory :invalid_login_password do
      email { 'johndoe@gmail.com' }
      password { 'bad password' }
    end

    factory :user_with_posts do
      transient do
        post_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.post_count, user: user)
        user.reload
      end
    end

    factory :user_with_downvote_posts do
      transient do
        post_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:downvote_post, evaluator.post_count, user: user)
        user.reload
      end
    end

    factory :first_user do
      first_name { 'John' }
      middle_name { 'Middle' }
      last_name { 'Doe' }
      email { 'johndoe@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :second_user do
      first_name { 'Jane' }
      middle_name { 'Jennings' }
      last_name { 'Rutherford' }
      email { 'janerutherford@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :third_user do
      first_name { 'Rayver' }
      middle_name { 'Cruz' }
      last_name { 'Bradford' }
      email { 'rayver@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :fourth_user do
      first_name { 'Rayver' }
      middle_name { 'Cruz' }
      last_name { 'Marasigan' }
      email { 'rayvermarasigan@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    factory :empty_user_email, traits: [:invalid]
  end
end
