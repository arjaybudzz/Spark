require 'rails_helper'

RSpec.describe 'Api::V1::PostTokens', type: :request do
  setup do
    @post = create(:post)
  end

  describe 'POST /create' do
    context 'generate token if input is valid' do
      let(:sample_post) { attributes_for(:post) }

      before do
        post api_v1_post_tokens_url,
          params: { post: sample_post }, as: :json
      end

      it { expect(json[:post_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if input is invalid' do
      let(:sample_post) { attributes_for(:other_post) }

      before do
        post api_v1_post_tokens_url,
          params: { post: sample_post }, as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
