class ComputeReaction
  def self.num_upvotes(post, num_upvote)
    post.upvote.to_i + num_upvote.to_i
  end

  def self.num_downvotes(post, num_downvote)
    post.downvote.to_i + num_downvote.to_i
  end
end
