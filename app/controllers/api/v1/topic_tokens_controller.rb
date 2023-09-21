class Api::V1::TopicTokensController < ApplicationController
  def create
    @topic = Topic.find_by_name(permitted_topic_params[:name])

    if @topic
      render json: {
        topic_token: JsonWebToken.encode(topic_id: @topic.id),
        name: @topic.name,
        discussion: @topic.discussion
      }
    else
      head :unauthorized
    end
  end

  private

  def permitted_topic_params
    params.require(:topic).permit(:name)
  end
end
