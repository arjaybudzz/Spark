module ReplyAuthentication
  def current_reply
    return @current_reply if @current_reply

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_reply = Reply.find(decoded[:reply_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_reply
    head :forbidden unless current_reply
  end
end
