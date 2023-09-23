require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  setup do
    @comment = create(:comment)
    @comment_valid_attribute = attributes_for(:comment)
    @comment_invalid_attributes = attributes_for(:empty_comment)
  end

  describe 'GET /index' do
    before do
      create_list(:comment, 9)
      get api_v1_comments_url, as: :json
    end

    it { expect(json.length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_comment_url(@comment), as: :json
    end

    it { expect(json[:body]).to match(@comment.body) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a ocmment if input is valid' do
      before do
        post api_v1_comments_url,
          params: { comment: @comment_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(post_id: @comment.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a comment if input is invalid' do
      before do
        post api_v1_comments_url,
          params: { comment: @comment_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(post_id: @comment.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a comment if there is no post' do
      before do
        post api_v1_comments_url,
          params: { comment: @comment_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update comment if input is valid' do
      before do
        put api_v1_comment_url(@comment),
          params: { comment: @comment_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(post_id: @comment.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update comment if input is invalid' do
      before do
        put api_v1_comment_url(@comment),
          params: { comment: @comment_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(post_id: @comment.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update comment if there is no post and comment' do
      before do
        put api_v1_comment_url(@comment),
          params: { comment: @comment_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy comment if authorized' do
      before do
        delete api_v1_comment_url(@comment),
          headers: { Authorization: JsonWebToken.encode(post_id: @comment.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy comment if user is not the owner' do
      before do
        delete api_v1_comment_url(@comment), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
