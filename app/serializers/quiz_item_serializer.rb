class QuizItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :problem, :point
end
