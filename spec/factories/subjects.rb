FactoryBot.define do
  factory :subject do
    name { Faker::Educator.subject }
    admin { association :admin }

    trait :invalid do
      name { nil }
    end

    factory :sample_subject do
      name { 'Science' }
    end

    trait :some_subject do
      name { 'Math' }
    end

    factory :empty_subject_name, traits: %i[invalid]
    factory :invalid_subject, traits: %i[some_subject]
  end
end
