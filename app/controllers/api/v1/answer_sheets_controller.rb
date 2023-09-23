class Api::V1::AnswerSheetsController < ApplicationController
  before_action :setup_answer_sheet, only: %i[show]
  before_action :check_existing_quiz, only: %i[create]

  def index
    @answer_sheet = AnswerSheet.all
    render json: @answer_sheet
  end

  def show
    render json: @answer_sheet
  end

  # Continue this controller

  private

  def setup_answer_sheet
    @answer_sheet = AnswerSheet.find(params[:id])
  end

  def permitted_answer_sheet_params
    params.require(:answer_sheet).permit(:score)
  end
end
