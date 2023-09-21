class SubjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  belongs_to :admin
  has_many :topics
end
