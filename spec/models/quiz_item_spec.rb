require 'rails_helper'

RSpec.describe QuizItem, type: :model do
  describe 'associations test' do
    it { should belong_to(:quiz) }
    it { should have_one(:quiz_answer).dependent(:destroy) }

    context 'automatically create a quiz answer model for the user to put their answer' do
      before do
        @quiz_item = create(:quiz_item)
      end

      it { expect(@quiz_item.create_quiz_answer_slot).to eq(@quiz_item.quiz_answer) }
    end
  end

  describe 'quiz problem validations' do
    it { should validate_presence_of(:problem) }
  end

  describe 'problem answer validations' do
    it { should validate_presence_of(:answer) }
  end

  describe 'problem point validations' do
    it { should validate_presence_of(:point) }
    it { should validate_numericality_of(:point).is_greater_than_or_equal_to(0) }
  end
end
