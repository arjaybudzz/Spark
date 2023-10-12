FactoryBot.define do
  factory :post_down_vote do
    is_clicked { true }
    post { association :post }
  end
end
