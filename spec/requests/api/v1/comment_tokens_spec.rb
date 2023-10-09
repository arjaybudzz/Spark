require 'rails_helper'

RSpec.describe 'Api::V1::CommentTokens', type: :request do
  setup do
    @comment = create(:comment)
  end

  describe 'POST /create' do
    context 'generate a token if reply is found' do
      let(:sample_comment) { attributes_for(:comment) }

      before do
        post api_v1_comment_tokens_url,
          params: { comment: sample_comment },
          as: :json
      end

      it { expect(json[:comment_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if reply is not found' do
      let(:sample_comment) { attributes_for(:other_comment) }

      before do
        post api_v1_comment_tokens_url,
          params: { comment: sample_comment },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
