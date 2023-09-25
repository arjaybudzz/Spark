module CommentAuthentication
  def current_comment
    return @current_comment if @current_comment

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_comment = Comment.find(decoded[:comment_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_comment
    head :forbidden unless current_comment
  end
end
