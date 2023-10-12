FactoryBot.define do
  factory :post_up_vote do
    is_clicked { true }
    post { association :post }
  end
end
