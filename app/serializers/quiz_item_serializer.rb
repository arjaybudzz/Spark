class QuizItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :problem, :point

  belongs_to :quiz
  has_one :quiz_answer
end
