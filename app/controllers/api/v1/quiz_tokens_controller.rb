class Api::V1::QuizTokensController < ApplicationController
  def create
    @quiz = Quiz.find_by_difficulty(permitted_quiz_params[:difficulty])

    if @quiz
      render json: {
        quiz_token: JsonWebToken.encode(quiz_id: @quiz.id),
        difficulty: @quiz.difficulty,
        score: @quiz.score
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_quiz_params
    params.require(:quiz).permit(:difficulty)
  end
end
