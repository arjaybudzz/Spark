require 'rails_helper'

RSpec.describe 'Api::V1::Quizzes', type: :request do
  setup do
    @quiz = create(:quiz_with_quiz_items)
    @quiz_with_answer_sheet = create(:quiz_with_answer_sheet)
    @quiz_valid_attribute = attributes_for(:quiz)
    @quiz_invalid_attribute = attributes_for(:empty_difficulty)
  end

  describe 'GET /index' do
    before do
      create_list(:quiz, 8)
      get api_v1_quizzes_url, as: :json
    end

    it { expect(json[:data].length).to eq(10) } # including the @quiz object above
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_quiz_url(@quiz_with_answer_sheet), as: :json
    end

    it { expect(json[:data][:attributes][:difficulty]).to match(@quiz_with_answer_sheet.difficulty) }

    it 'matches associated topic' do
      expect(json[:data][:relationships][:topic][:data][:id]).to match(@quiz_with_answer_sheet.topic.id.to_s)
    end

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a quiz if the input is valid and there is an existing topic' do
      before do
        post api_v1_quizzes_url,
          params: { quiz: @quiz_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(topic_id: @quiz.topic_id) }
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a quiz if info is invalid but there is an existing topic' do
      before do
        post api_v1_quizzes_url,
          params: { quiz: @quiz_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(topic_id: @quiz.topic_id) }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a quiz without existing topic' do
      before do
        post api_v1_quizzes_url,
          params: { quiz: @quiz_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update quiz if input is valid and the current quiz is existing' do
      before do
        put api_v1_quiz_url(@quiz),
          params: { quiz: @quiz_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(topic_id: @quiz.topic_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update quiz if input is invalid but the quiz is existing' do
      before do
        put api_v1_quiz_url(@quiz),
          params: { quiz: @quiz_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(topic_id: @quiz.topic_id) }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update if quiz is not existing' do
      before do
        put api_v1_quiz_url(@quiz),
          params: { quiz: @quiz_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy quiz if it exists and authorized' do
      before do
        delete api_v1_quiz_url(@quiz),
          headers: { Authorization: JsonWebToken.encode(topic_id: @quiz.topic_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy if quiz does not exist' do
      before do
        delete api_v1_quiz_url(@quiz), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
