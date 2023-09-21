class QuizSerializer
  include FastJsonapi::ObjectSerializer
  attributes :difficulty, :score
end
