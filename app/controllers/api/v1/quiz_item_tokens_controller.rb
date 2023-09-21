class Api::V1::QuizItemTokensController < ApplicationController
  def create
    @quiz_item = QuizItem.find_by_problem(permitted_quiz_item_param[:problem])

    if @quiz_item
      render json: {
        quiz_item_token: JsonWebToken.encode(quiz_item_id: @quiz_item.id),
        problem: @quiz_item.problem,
        point: @quiz_item.point
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_quiz_item_param
    params.require(:quiz_item).permit(:problem)
  end
end
