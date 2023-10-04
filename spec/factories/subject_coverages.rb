FactoryBot.define do
  factory :subject_coverage do
    name { "MyString" }
    admin { association :admin }

    trait :invalid do
      name { nil }
    end

    trait :wrong do
      name { "other string" }
    end

    factory :empty_name, traits: %i[invalid]
    factory :wrong_name, traits: %i[wrong]
  end
end
