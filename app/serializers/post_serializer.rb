class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote

  belongs_to :user
  has_many :comments
end
