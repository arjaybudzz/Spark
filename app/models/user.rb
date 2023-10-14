class User < ApplicationRecord
  include CommonUserDataValidation
  belongs_to :admin
  has_many :answer_sheets, dependent: :destroy
  has_many :quizzes, through: :answer_sheets
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :post_up_votes, through: :posts
  has_many :post_down_votes, through: :posts

  validates :credibility, presence: true

  scope :filter_by_first_name, lambda { |keyword| where("lower(first_name) LIKE ?", "%#{keyword.downcase}%") }
end
