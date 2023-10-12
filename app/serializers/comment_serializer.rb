class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote, :user_name

  belongs_to :post
  has_many :replies
  has_many :comment_up_votes
  has_many :comment_down_votes
end
