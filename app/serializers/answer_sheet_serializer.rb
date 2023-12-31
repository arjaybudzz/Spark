class AnswerSheetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :score

  belongs_to :user
  belongs_to :quiz
  has_many :quiz_answers
end
