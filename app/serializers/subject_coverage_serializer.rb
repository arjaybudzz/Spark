class SubjectCoverageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  belongs_to :admin
end
