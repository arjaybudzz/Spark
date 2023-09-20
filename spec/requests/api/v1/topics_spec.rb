require 'rails_helper'

RSpec.describe 'Api::V1::Topics', type: :request do

  setup do
    @topic = create(:topic)
    @topic_valid_attributes = attributes_for(:topic)
    @topic_invalid_attributes = attributes_for(:empty_topic_name)
  end

  describe 'GET /index' do
    before do
      create_list(:topic, 9)
      get api_v1_topics_url, as: :json
    end

    it { expect(json.length).to eq(10) } # including the topic object at the setup
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_topic_url(@topic), as: :json
    end

    it { expect(json['name']).to match(@topic.name) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a topic if input is valid and there is an existing subject' do
      before do
        post api_v1_topics_url,
          params: { topic: @topic_valid_attributes },
          headers: { Authorization: JsonWebToken.encode(subject_id: @topic.subject_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context "don't create a topic if input is invalid but there is an existing subject" do
      before do
        post api_v1_topics_url,
          params: { topic: @topic_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(subject_id: @topic.subject_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'do not create a topic if there is no existing subject' do
      before do
        post api_v1_topics_url,
          params: { topic: @topic_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update info if input is valid and current topic is existing' do
      before do
        put api_v1_topic_url(@topic),
          params: { topic: @topic_valid_attributes },
          headers: { Authorization: JsonWebToken.encode(subject_id: @topic.subject_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update if input is invalid but current topic is existing' do
      before do
        put api_v1_topic_url(@topic),
          params: { topic: @topic_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(subject_id: @topic.subject_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update if current_topic is not existing' do
      before do
        put api_v1_topic_url(@topic),
          params: { topic: @topic_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy topic if topic is existing' do
      before do
        delete api_v1_topic_url(@topic),
          headers: { Authorization: JsonWebToken.encode(subject_id: @topic.subject_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy topic if topic does not exist' do
      before do
        delete api_v1_topic_url(@topic), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
