FactoryBot.define do
  factory :topic do
    name { Faker::Educator.unique.course_name }
    discussion { Faker::Lorem.paragraph }
    subject { association :subject }

    factory :sample_topic do
      name { 'Linear Equations ' }
      discussion { 'x + y = 2' }
    end

    trait :invalid do
      name { nil }
    end

    factory :empty_topic_name, traits: [:invalid]
  end
end
