class Api::V1::QuizzesController < ApplicationController
  before_action :setup_quiz, only: %i[show update destroy]
  before_action :check_existing_topic, only: %i[create]
  before_action :check_quiz, only: %i[update destroy]

  def index
    @quiz = Quiz.all
    render json: QuizSerializer.new(@quiz).serializable_hash
  end

  def show
    options = { include: %i[topic quiz_items answer_sheet] }
    render json: QuizSerializer.new(@quiz, options).serializable_hash
  end

  def create
    @quiz = current_topic.quizzes.build(permitted_quiz_params)

    if @quiz.save
      render json: QuizSerializer.new(@quiz).serializable_hash, status: :created
    else
      render json: @quiz.errors, status: :unprocessable_entity
    end
  end

  def update
    if @quiz.update(permitted_quiz_params)
      render json: QuizSerializer.new(@quiz).serializable_hash, status: :ok
    else
      render json: @quiz.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz.destroy
    head 204
  end

  private

  def setup_quiz
    @quiz = Quiz.find(params[:id])
  end

  def permitted_quiz_params
    params.require(:quiz).permit(:difficulty, :score)
  end

  def check_quiz
    head :forbidden unless @quiz.topic_id == current_topic&.id
  end
end
