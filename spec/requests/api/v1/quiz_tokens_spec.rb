require 'rails_helper'

RSpec.describe 'Api::V1::QuizTokens', type: :request do
  setup do
    @quiz = create(:quiz_sample)
  end

  describe 'POST /create' do
    context 'generate token if input is valid and quiz is found' do
      let(:easy_quiz) { attributes_for(:quiz_sample) }

      before do
        post api_v1_quiz_tokens_url,
          params: { quiz: easy_quiz },
          as: :json
      end

      it { expect(json[:quiz_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if input is invalid and quiz is not found' do
      let(:medium) { attributes_for(:medium_quiz) }

      before do
        post api_v1_quiz_tokens_url,
          params: { quiz: medium },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
