class Api::V1::QuizAnswersController < ApplicationController
  before_action :setup_quiz_answer, only: %i[show update]
  before_action :check_current_answer_sheet, only: %i[create]

  def index
    @quiz_answer = QuizAnswer.all
    render json: QuizAnswerSerializer.new(@quiz_answer).serializable_hash
  end

  def show
    options = { include: %i[quiz_item answer_sheet quiz_answer] }
    render json: QuizAnswerSerializer.new(@quiz_answer, options).serializable_hash
  end

  def update
    if @quiz_answer.update(permitted_quiz_answer_params)
      render json: QuizAnswerSerializer.new(@quiz_answer).serializable_hash, status: :ok
    else
      render json: @quiz_answer.errors, status: :unprocessable_entity
    end
  end

  private

  def setup_quiz_answer
    @quiz_answer = QuizAnswer.find(params[:id])
  end

  def permitted_quiz_answer_params
    params.require(:quiz_answer).permit(:answer)
  end
end
