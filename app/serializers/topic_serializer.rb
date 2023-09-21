class TopicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :discussion
  belongs_to :subject
  has_many :quizzes
end
