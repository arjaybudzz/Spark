class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :middle_name, :last_name, :email, :credibility

  belongs_to :admin
  has_many :answer_sheets
  has_many :posts
  has_many :comments, through: :posts
  has_many :post_up_votes, through: :posts
  has_many :post_down_votes, through: :posts
end
