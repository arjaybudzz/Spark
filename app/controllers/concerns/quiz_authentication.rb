module QuizAuthentication
  def current_quiz
    return @current_quiz if @current_quiz

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_quiz = Quiz.find(decoded[:quiz_id]) rescue ActiveRecord::RecordNotFound
  end
end
