require 'rails_helper'

RSpec.describe AnswerSheetAuthentication do
  setup do
    @answer_sheet = create(:answer_sheet)
    @authentication = MockController.new
  end

  describe 'should get answer sheet from authentication token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(answer_sheet_id: @answer_sheet.id)
    end

    it { expect(@authentication.current_answer_sheet.id).to eq(@answer_sheet.id) }
  end

  describe 'should not get answer sheet if unauthorized' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_answer_sheet.nil?).to eq(true) }
  end
end
