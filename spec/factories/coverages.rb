FactoryBot.define do
  factory :coverage do
    name { "MyString" }
    admin { association :admin }
  end
end
