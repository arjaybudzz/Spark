class QuizSerializer
  include FastJsonapi::ObjectSerializer
  attributes :difficulty, :score

  belongs_to :topic
  has_many :quiz_items
end
