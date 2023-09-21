class Topic < ApplicationRecord
  belongs_to :subject
  has_many :quizzes, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :subject_id }
  validates :discussion, presence: true
end
