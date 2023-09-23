require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  setup do
    @post = create(:post)
    @post_valid_attributes = attributes_for(:post)
    @post_invalid_attributes = attributes_for(:empty_post)
  end

  describe 'GET /index' do
    before do
      create_list(:post, 9)
      get api_v1_posts_url, as: :json
    end

    it { expect(json.length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_post_url(@post), as: :json
    end

    it { expect(json[:body]).to match(@post.body) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a post if input is valid' do
      before do
        post api_v1_posts_url,
          params: { post: @post_valid_attributes },
          headers: { Authorization: JsonWebToken.encode(user_id: @post.user_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a post if input is invalid' do
      before do
        post api_v1_posts_url,
          params: { post: @post_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(user_id: @post.user_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a post if there is no user' do
      before do
        post api_v1_posts_url,
          params: { post: @post_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update post if input is valid' do
      before do
        put api_v1_post_url(@post),
          params: { post: @post_valid_attributes },
          headers: { Authorization: JsonWebToken.encode(user_id: @post.user_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update post if input is invalid' do
      before do
        put api_v1_post_url(@post),
          params: { post: @post_invalid_attributes },
          headers: { Authorization: JsonWebToken.encode(user_id: @post.user_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update post if there is no post' do
      before do
        put api_v1_post_url(@post),
          params: { post: @post_valid_attributes },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy post if user is the owner' do
      before do
        delete api_v1_post_url(@post),
          headers: { Authorization: JsonWebToken.encode(user_id: @post.user_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy if user is not the owner' do
      before do
        delete api_v1_post_url(@post), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end
