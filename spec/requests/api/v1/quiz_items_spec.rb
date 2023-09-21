require 'rails_helper'

RSpec.describe "Api::V1::QuizItems", type: :request do
  before do
    @quiz_item = create(:quiz_item)
    @quiz_item_valid_attributes = attributes_for(:quiz_item)
    @quiz_item_invalid_attributes = attributes_for(:empty_quiz_problem)
  end

  describe 'GET /index' do
    before do
      create_list(:quiz_item, 9)
      get api_v1_quiz_items_url, as: :json
    end

    it { expect(json[:data].length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_quiz_item_url(@quiz_item), as: :json
    end

    it { expect(json[:data][:attributes][:problem]).to match(@quiz_item.problem) }
    it 'should match associated quiz' do
      expect(json[:data][:relationships][:quiz][:data][:id]).to match(@quiz_item.quiz.id.to_s)
      expect(json[:included][0][:attributes][:difficulty]).to match(@quiz_item.quiz.difficulty)
    end
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a quiz item if info is valid and there is an existing quiz' do
      before do
        post api_v1_quiz_items_url,
          params: { quiz_item: @quiz_item_valid_attributes},
          headers: { Authorization: JsonWebToken.encode(quiz_id: @quiz_item.quiz_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a quiz item if info is invalid but there is an existing quiz' do
      before do
        post api_v1_quiz_items_url,
          params: { quiz_item: @quiz_item_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(quiz_id: @quiz_item.quiz_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a quiz item without a quiz' do
      before do
        post api_v1_quiz_items_url,
          params: { quiz_item: @quiz_item_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update quiz item if info is valid' do
      before do
        put api_v1_quiz_item_url(@quiz_item),
          params: { quiz_item: @quiz_item_valid_attributes},
          headers: { Authorization: JsonWebToken.encode(quiz_id: @quiz_item.quiz_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update quiz item if info is invalid' do
      before do
        put api_v1_quiz_item_url(@quiz_item),
          params: { quiz_item: @quiz_item_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(quiz_id: @quiz_item.quiz_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update if quiz item does not exist' do
      before do
        put api_v1_quiz_item_url(@quiz_item),
          params: { quiz_item: @quiz_item_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy quiz item if authorized' do
      before do
        delete api_v1_quiz_item_url(@quiz_item),
          headers: { Authorization: JsonWebToken.encode(quiz_id: @quiz_item.quiz_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy quiz item if unauthorized' do
      before do
        delete api_v1_quiz_item_url(@quiz_item), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
