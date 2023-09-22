require 'rails_helper'

RSpec.describe 'Api::V1::UserTokens', type: :request do
  setup do
    @user = create(:user_sample)
  end

  describe 'POST /create' do
    context 'generate token if authorized' do
      let(:login_sample) { attributes_for(:login) }

      before do
        post api_v1_user_tokens_url,
          params: { user: login_sample },
          as: :json
      end

      it { expect(json[:user_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if unauthorized' do
      let(:login_sample) { attributes_for(:invalid_login_password) }

      before do
        post api_v1_user_tokens_url,
          params: { user: login_sample },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
