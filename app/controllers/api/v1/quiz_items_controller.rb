class Api::V1::QuizItemsController < ApplicationController
  before_action :setup_quiz_item, only: %i[show update destroy]
  before_action :check_existing_quiz, only: %i[create index]
  before_action :check_quiz, only: %i[update destroy]

  wrap_parameters include: %i[problem answer point first_choice second_choice third_choice fourth_choice]

  def index
    @quiz_item = current_quiz.quiz_items.page(current_page).per(1)

    options = {
      links: {
        first: api_v1_quiz_items_path(page: 1),
        last: api_v1_quiz_items_path(page: @quiz_item.total_pages),
        prev: api_v1_quiz_items_path(page: @quiz_item.prev_page),
        next: api_v1_quiz_items_path(page: @quiz_item.next_page)
      }
    }

    render json: QuizItemSerializer.new(@quiz_item, options).serializable_hash
  end

  def show
    options = { include: %i[quiz quiz_answer] }
    render json: QuizItemSerializer.new(@quiz_item, options).serializable_hash
  end

  def create
    @quiz_item = current_quiz.quiz_items.build(permitted_quiz_item_params)

    if @quiz_item.save
      render json: QuizItemSerializer.new(@quiz_item).serializable_hash, status: :created
    else
      render json: @quiz_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @quiz_item.update(permitted_quiz_item_params)
      render json: QuizItemSerializer.new(@quiz_item).serializable_hash, status: :ok
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
    params.require(:quiz_item).permit(:problem, :first_choice, :second_choice, :third_choice, :fourth_choice, :answer, :point)
  end

  def check_quiz
    head :forbidden unless @quiz_item.quiz_id == current_quiz&.id
  end
end
