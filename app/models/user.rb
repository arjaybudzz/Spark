class User < ApplicationRecord
  include CommonUserDataValidation
  belongs_to :admin
  has_many :answer_sheets, dependent: :destroy
  has_many :quizzes, through: :answer_sheets
  has_many :posts, dependent: :destroy

  validates :credibility, presence: true
end
