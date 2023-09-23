require 'rails_helper'

RSpec.describe QuizAnswer, type: :model do
  describe 'association validations' do
    it { should belong_to(:answer_sheet) }
    it { should belong_to(:quiz_item) }
  end

  describe 'quiz answer validations' do
    it { should validate_presence_of(:answer) }
  end
end
