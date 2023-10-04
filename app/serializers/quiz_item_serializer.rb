class QuizItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :problem, :point, :first_choice, :second_choice, :third_choice, :fourth_choice

  belongs_to :quiz
  has_one :quiz_answer
end
