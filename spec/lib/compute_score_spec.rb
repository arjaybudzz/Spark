require 'rails_helper'

RSpec.describe ComputeScore do
  setup do
    @answer_sheet = create(:answer_sheet_with_correct_answers)
    @wrong_answers = create(:answer_sheet_with_wrong_answers)
  end

  describe 'user got a correct answer' do
    before do
      ComputeScore.check_answer(@answer_sheet)
    end

    it { expect(@answer_sheet.score).to eq(10) }
  end

  describe 'user got a wrong answer' do
    before do
      ComputeScore.check_answer(@wrong_answers)
    end

    it { expect(@wrong_answers.score).to eq(0) }
  end
end
