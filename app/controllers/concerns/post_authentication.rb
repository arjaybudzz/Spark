module PostAuthentication
  def current_post
    return @current_post if @current_post

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_post = Post.find(decoded[:post_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_post
    head :forbidden unless current_post
  end
end
