class QuizAnswer < ApplicationRecord
  belongs_to :quiz_item
  belongs_to :answer_sheet

  validates :answer, presence: true
end
