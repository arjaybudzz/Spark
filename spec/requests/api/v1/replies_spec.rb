require 'rails_helper'

RSpec.describe 'Api::V1::Replies', type: :request do
  setup do
    @reply = create(:reply)
    @reply_valid_attributes = attributes_for(:reply)
    @reply_invalid_attributes = attributes_for(:empty_reply)
  end

  describe 'GET /index' do
    before do
      create_list(:reply, 9)
      get api_v1_replies_url, as: :json
    end

    it { expect(json[:data].length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_reply_url(@reply), as: :json
    end

    it { expect(json[:data][:attributes][:body]).to match(@reply.body) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a reply if input is valid and the comment exists' do
      before do
        post api_v1_replies_url,
          params: { reply: @reply_valid_attributes },
          headers: { Authorization: JsonWebToken.encode(comment_id: @reply.comment_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a reply if input is invalid' do
      before do
        post api_v1_replies_url,
          params: { reply: @reply_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(comment_id: @reply.comment_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a reply if there is no comment' do
      before do
        post api_v1_replies_url,
          params: { reply: @reply_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update if info is valid' do
      before do
        put api_v1_reply_url(@reply),
          params: { reply: @reply_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update if info is invalid' do
      before do
        put api_v1_reply_url(@reply),
          params: { reply: @reply_invalid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy reply if authorized' do
      before do
        delete api_v1_reply_url(@reply),
        headers: { Authorization: JsonWebToken.encode(comment_id: @reply.comment_id) },
        as: :json

      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid destroy reply if unauthorized' do
      before do
        delete api_v1_reply_url(@reply),
        as: :json

      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
