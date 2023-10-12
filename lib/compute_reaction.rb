class ComputeReaction
  def self.compute_upvote(post)
    post.update(upvote: PostUpVote.count)
  end
end
