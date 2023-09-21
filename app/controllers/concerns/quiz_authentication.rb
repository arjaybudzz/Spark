module QuizAuthentication
  def current_quiz
    return @current_quiz if @current_quiz

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_quiz = Quiz.find(decoded[:quiz_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_existing_quiz
    head :forbidden unless current_quiz
  end
end
