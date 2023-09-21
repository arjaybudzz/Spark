require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  setup do
    @admin = create(:admin_sample)
  end

  describe 'POST /create' do
    context 'generate token if password is valid' do
      let(:admin_params) { attributes_for(:valid_login) }

      before do
        post api_v1_tokens_url, params: { admin: admin_params }, as: :json
      end

      it { expect(json[:token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if unauthorized' do
      let(:admin_params) { attributes_for(:wrong_password) }

      before do
        post api_v1_tokens_url, params: { admin: admin_params }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
