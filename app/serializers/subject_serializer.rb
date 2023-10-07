class SubjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  belongs_to :subject_coverage
  has_many :topics
end
