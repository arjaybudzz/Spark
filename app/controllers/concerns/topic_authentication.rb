module TopicAuthentication
  def current_topic
    return @current_topic if @current_topic

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_topic = Topic.find(decoded[:topic_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_topic
    head :forbidden unless current_topic
  end
end
