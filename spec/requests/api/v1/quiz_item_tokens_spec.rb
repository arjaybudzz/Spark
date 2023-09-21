require 'rails_helper'

RSpec.describe 'Api::V1::QuizItemTokens', type: :request do
  before do
    @quiz_item = create(:quiz_item)
  end

  describe 'POST /create' do
    context 'generate token if input is correct' do
      let(:sample_quiz_item) { attributes_for(:quiz_item) }

      before do
        post api_v1_quiz_item_tokens_url,
          params: { quiz_item: sample_quiz_item },
          as: :json
      end

      it { expect(json[:quiz_item_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if input is wrong' do
      let(:sample_quiz_item) { attributes_for(:wrong_problem) }

      before do
        post api_v1_quiz_item_tokens_url,
          params: { quiz_item: sample_quiz_item },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
