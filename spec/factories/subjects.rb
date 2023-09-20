FactoryBot.define do
  factory :subject do
    name { Faker::Name.first_name }
    admin { association :admin }

    trait :invalid do
      name { nil }
    end

    trait :some_subject do
      name { 'Math' }
    end

    factory :sample_subject do
      name { 'Science' }
    end

    factory :subject_with_topics do
      transient do
        topics_count { 10 }
      end

      after(:create) do |subject, evaluator|
        create_list(:topic, evaluator.topics_count, subject: subject)

        subject.reload
      end
    end

    factory :empty_subject_name, traits: %i[invalid]
    factory :invalid_subject, traits: %i[some_subject]
  end
end