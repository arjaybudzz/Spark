class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :middle_name, :last_name, :email, :credibility

  belongs_to :admin
  has_many :answer_sheets
  has_many :posts
  has_many :comments, through: :posts
end
