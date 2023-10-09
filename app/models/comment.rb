class Comment < ApplicationRecord
  include CommonPostDataValidation
  belongs_to :post
  has_many :replies, dependent: :destroy

  validates :user_name, presence: true
end
