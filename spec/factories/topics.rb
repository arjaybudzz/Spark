FactoryBot.define do
  factory :topic do
    name { Faker::Educator.unique.course_name }
    discussion { Faker::Lorem.paragraph }
    subject { association :subject }

    factory :sample_topic do
      name { 'Linear Equations ' }
      discussion { 'x + y = 2' }
      subject { association :subject }
    end

    trait :invalid do
      name { nil }
    end

    trait :valid do
      name { 'Linear Equations' }
    end

    trait :other_name do
      name { 'Quadratic Equations' }
    end

    factory :topic_with_quizzes do
      transient do
        quizzes_count { 5 }
      end

      after(:create) do |topic, evaluator|
        create_list(:quiz, evaluator.quizzes_count, topic: topic)
        topic.reload
      end
    end

    factory :linear_equation_topic, traits: [:valid]
    factory :quadratic_equation_topic, traits: [:other_name]
    factory :empty_topic_name, traits: [:invalid]
  end
end
