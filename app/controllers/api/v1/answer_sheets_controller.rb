class Api::V1::AnswerSheetsController < ApplicationController
  before_action :setup_answer_sheet, only: %i[show]
  before_action :check_existing_quiz, only: %i[create]

  def index
    @answer_sheet = AnswerSheet.all
    render json: AnswerSheetSerializer.new(@answer_sheet).serializable_hash
  end

  def show
    options = { include: %i[user quiz quiz_answers] }
    render json: AnswerSheetSerializer.new(@answer_sheet, options).serializable_hash
  end

  private

  def setup_answer_sheet
    @answer_sheet = AnswerSheet.find(params[:id])
  end
end
