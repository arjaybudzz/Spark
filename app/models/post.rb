class Post < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_up_votes, dependent: :destroy
  has_many :post_down_votes, dependent: :destroy
end
