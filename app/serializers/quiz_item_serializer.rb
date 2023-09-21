class QuizItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :problem, :point

  belongs_to :quiz
end
