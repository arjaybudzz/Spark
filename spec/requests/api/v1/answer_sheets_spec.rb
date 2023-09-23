require 'rails_helper'

RSpec.describe 'Api::V1::AnswerSheets', type: :request do
  setup do
    @answer_sheet = create(:answer_sheet)
    @answer_sheet_sample = attributes_for(:answer_sheet)
    @invalid_answer_sheet = attributes_for(:empty_quiz)
  end

  describe 'GET /index' do
    before do
      create_list(:answer_sheet, 9)
      get api_v1_answer_sheets_url, as: :json
    end
    it { expect(json[:data].length).to eq(19) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_answer_sheet_url(@answer_sheet), as: :json
    end

    it { expect(json[:data][:attributes][:score]).to match(@answer_sheet.score) }
    it { expect(response).to have_http_status(:success) }

    it 'should match its associated quiz' do

      expect(json[:data][:relationships][:quiz][:data][:id]).to match(@answer_sheet.quiz.id.to_s)
    end

    it 'should match its associated user' do
      expect(json[:data][:relationships][:user][:data][:id]).to match(@answer_sheet.user.id.to_s)
    end
  end
end
