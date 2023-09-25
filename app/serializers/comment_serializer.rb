class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :upvote, :downvote

  belongs_to :post
end
