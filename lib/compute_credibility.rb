class ComputeCredibility
  def self.compute(user)
    begin
      total_upvotes = 0
      total_downvotes = 0
      user.posts.each do |post|
        total_upvotes += post.upvote.to_f
        total_downvotes += post.downvote.to_f
      end

      credibility = total_upvotes.to_f / (total_upvotes.to_f + total_downvotes.to_f)

      user.update(credibility: format('%.2f', credibility))
    rescue ZeroDivisionError
      user.update(credibility: 0)
    end
  end
end
