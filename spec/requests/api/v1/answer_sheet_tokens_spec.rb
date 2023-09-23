require 'rails_helper'

RSpec.describe 'Api::V1::AnswerSheetTokens', type: :request do
  setup do
    @user = create(:user)
    @quiz = create(:quiz)
    @answer_sheet = create(:answer_sheet, user_id: @user.id, quiz_id: @quiz.id)
  end

  describe 'POST /create' do
    context 'return answer sheet if authorized' do
      let(:authorized_answer_sheet) { attributes_for(:answer_sheet) }

      before do
        post api_v1_answer_sheet_tokens_url,
          params: { answer_sheet: authorized_answer_sheet },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'do not return answer sheet if unauthorized' do
      let(:unauthorized_answer_sheet) { attributes_for(:wrong) }

      before do
        post api_v1_answer_sheet_tokens_url,
          params: { answer_sheet: unauthorized_answer_sheet },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
