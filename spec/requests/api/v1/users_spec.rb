require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  setup do
    @user = create(:user)
    @user_valid_attribute = attributes_for(:user)
    @user_invalid_attribute = attributes_for(:empty_user_email)
  end

  describe 'GET /index' do
    before do
      create_list(:user, 9)
      get api_v1_users_url, as: :json
    end

    it { expect(json.length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_user_url(@user), as: :json
    end

    it { expect(json[:email]).to match(@user.email) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create a user if info is valid and it belongs to admin' do
      before do
        post api_v1_users_url,
          params: { user: @user_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @user.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create a user if info is invalid but it belongs to an admin' do
      before do
        post api_v1_users_url,
          params: { user: @user_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @user.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to create a user if there is no admin' do
      before do
        post api_v1_users_url,
          params: { user: @user_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'PUT /update' do
    context 'update user if input is valid' do
      before do
        put api_v1_user_url(@user),
          params: { user: @user_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @user.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update user if input is invalid' do
      before do
        put api_v1_user_url(@user),
          params: { user: @user_invalid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @user.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update user if it is not the owner of the account' do
      before do
        put api_v1_user_url(@user),
          params: { user: @user_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy user if authorized' do
      before do
        delete api_v1_user_url(@user),
          headers: { Authorization: JsonWebToken.encode(admin_id: @user.admin_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy user if unauthorized' do
      before do
        delete api_v1_user_url(@user), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end
end