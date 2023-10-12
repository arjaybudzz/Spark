class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote

  belongs_to :user
  has_many :comments
  has_many :post_up_votes
  has_many :post_down_votes
end
