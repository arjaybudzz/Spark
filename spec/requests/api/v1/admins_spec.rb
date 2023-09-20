require 'rails_helper'

RSpec.describe 'Api::V1::Admins', type: :request do

  setup do
    @admin = create(:admin)
    @admin_valid_attribute = attributes_for(:admin)
    @admin_invalid_attribute = attributes_for(:empty_email)
  end

  describe 'GET /index' do
    before do
      create_list(:admin, 9)
      get api_v1_admins_url, as: :json
    end

    it { expect(json.length).to eq(10) } #including the @admin in the setup
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_admin_url(@admin), as: :json
    end

    it { expect(json['email']).to match(@admin.email) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'create admin if input is valid' do
      before do
        post api_v1_admins_url, params: { admin: @admin_valid_attribute }, as: :json
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'do not create admin if input is invalid' do
      before do
        post api_v1_admins_url, params: { admin: @admin_invalid_attribute }, as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT /update' do
    context 'update info if input is valid and logged in' do
      before do
        put api_v1_admin_url(@admin), params: { admin: @admin_valid_attribute },
          headers: { Authorization: JsonWebToken.encode(admin_id: @admin.id) },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not update if input is invalid but logged in' do
      before do
        put api_v1_admin_url(@admin),
          headers: { Authorization: JsonWebToken.encode(admin_id: @admin.id) },
          params: { admin: @admin_invalid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    context 'forbid to update if not logged in' do
      before do
        put api_v1_admin_url(@admin),
          params: { admin: @admin_valid_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe 'DELETE /destroy' do
    context 'destroy admin if logged in' do
      before do
        delete api_v1_admin_url(@admin),
          headers: { Authorization: JsonWebToken.encode(admin_id: @admin.id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'forbid to destroy admin if not logged in' do
      before do
        delete api_v1_admin_url(@admin), as: :json
      end

      it { expect(response).to have_http_status(:forbidden) }
    end

  end
end
