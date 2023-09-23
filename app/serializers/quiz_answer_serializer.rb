class QuizAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :answer

  belongs_to :quiz_item
  belongs_to :answer_sheet
end
