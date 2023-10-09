require 'rails_helper'

RSpec.describe 'Api::V1::QuizAnswers', type: :request do
  setup do
    @quiz_answer = create(:quiz_answer)
    @quiz_answer_valid_params = attributes_for(:quiz_answer)
    @quiz_answer_invalid_params = attributes_for(:empty_answer)
    @quiz_item = create(:quiz_item)
  end

  describe 'GET /index' do
    before do
      create_list(:quiz_answer, 9)
      get api_v1_quiz_answers_url, as: :json
    end

    it { expect(json[:data].length).to eq(20) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_quiz_answer_url(@quiz_answer), as: :json
    end

    it { expect(json[:data][:attributes][:answer]).to match(@quiz_answer.answer) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'PUT /update' do
    context 'update quiz answer if input is valid' do
      before do
        put api_v1_quiz_answer_url(@quiz_answer),
          params: { quiz_answer: @quiz_answer_valid_params },
          headers: { Authorization: JsonWebToken.encode(quiz_item_id: @quiz_answer.quiz_item_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update if answer is empty or invalid' do
      before do
        put api_v1_quiz_answer_url(@quiz_answer),
          params: { quiz_answer: @quiz_answer_invalid_params },
          headers: { Authorization: JsonWebToken.encode(quiz_item_id: @quiz_answer.quiz_item_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update if it does not belong to a quiz item' do
      before do
        put api_v1_quiz_answer_url(@quiz_answer),
          params: { quiz_answer: @quiz_answer_valid_params },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
