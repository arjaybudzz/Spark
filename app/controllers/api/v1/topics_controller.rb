class Api::V1::TopicsController < ApplicationController
  before_action :setup_topic, only: %i[show update destroy]
  before_action :check_existing_subject, only: %i[create]
  before_action :check_subject, only: %i[update destroy]

  def index
    @topic = Topic.all
    render json: @topic
  end

  def show
    render json: @topic
  end

  def create
    @topic = current_subject.topics.build(permitted_topic_params)

    if @topic.save
      render json: @topic, status: :created
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  def update
    if @topic.update(permitted_topic_params)
      render json: @topic, status: :ok
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @topic.destroy
    head 204
  end

  private

  def setup_topic
    @topic = Topic.find(params[:id])
  end

  def permitted_topic_params
    params.require(:topic).permit(:name, :discussion)
  end

  def check_subject
    head :forbidden unless @topic.subject_id == current_subject&.id
  end
end
