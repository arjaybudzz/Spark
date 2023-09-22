require 'rails_helper'

RSpec.describe 'Api::V1::AnswerSheets', type: :request do
  setup do
    @answer_sheet = create(:answer_sheet)
  end

  describe 'GET /index' do
    before do
      create_list(:answer_sheet, 9)
      get api_v1_answer_sheets_url, as: :json
    end

    it { expect(json.length).to eq(10) }
    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before do
      get api_v1_answer_sheet_url(@answer_sheet), as: :json
    end

    it { expect(json[:score]).to match(@answer_sheet.score) }
    it { expect(response).to have_http_status(:success) }
  end
end
