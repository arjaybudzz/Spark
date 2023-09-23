class Api::V1::AnswerSheetTokensController < ApplicationController
  def create
    @answer_sheet = AnswerSheet.find_by_score(permitted_answer_sheet_params[:score])

    if @answer_sheet
      render json: {
        answer_sheet_token: JsonWebToken.encode(answer_sheet_id: @answer_sheet.id),
        score: @answer_sheet.score,
        quiz_id: @answer_sheet.quiz_id,
        user_id: @answer_sheet.user_id
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_answer_sheet_params
    params.require(:answer_sheet).permit(:score)
  end
end
