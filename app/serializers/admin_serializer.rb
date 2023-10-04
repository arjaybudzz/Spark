class AdminSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :middle_name, :last_name, :email
  has_many :subjects
  has_many :users
  has_many :subject_coverages
end
