class Api::V1::AnswerSheetsController < ApplicationController
  before_action :setup_answer_sheet, only: %i[show]

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
end
