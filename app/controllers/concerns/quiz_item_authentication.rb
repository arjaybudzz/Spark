module QuizItemAuthentication
  def current_quiz_item
    return @current_quiz_item if @current_quiz_item

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_quiz_item = QuizItem.find(decoded[:quiz_item_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_quiz_item
    head :forbidden unless current_quiz_item
  end
end
