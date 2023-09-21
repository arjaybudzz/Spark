class Api::V1::QuizItemsController < ApplicationController
  before_action :setup_quiz_item, only: %i[show update destroy]
  before_action :check_existing_quiz, only: %i[create]
  before_action :check_quiz, only: %i[update destroy]

  def index
    @quiz_item = QuizItem.all

    render json: @quiz_item
  end

  def show
    render json: @quiz_item
  end

  def create
    @quiz_item = current_quiz.quiz_items.build(permitted_quiz_item_params)

    if @quiz_item.save
      render json: @quiz_item, status: :created
    else
      render json: @quiz_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @quiz_item.update(permitted_quiz_item_params)
      render json: @quiz_item, status: :ok
    else
      render json: @quiz_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_item.destroy
    head 204
  end

  private

  def setup_quiz_item
    @quiz_item = QuizItem.find(params[:id])
  end

  def permitted_quiz_item_params
    params.require(:quiz_item).permit(:problem, :answer, :point)
  end

  def check_quiz
    head :forbidden unless @quiz_item.quiz_id == current_quiz&.id
  end
end
