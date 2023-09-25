require 'rails_helper'

RSpec.describe 'Api::V1::CommentTokens', type: :request do
  setup do
    @reply = create(:reply)
  end

  describe 'POST /create' do
    context 'generate a token if reply is found' do
      let(:sample_reply) { attributes_for(:reply) }

      before do
        post api_v1_comment_tokens_url,
          params: { reply: sample_reply },
          as: :json
      end

      it { expect(json[:reply_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if reply is not found' do
      let(:sample_reply) { attributes_for(:other_reply) }

      before do
        post api_v1_comment_tokens_url,
          params: { reply: sample_reply },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
