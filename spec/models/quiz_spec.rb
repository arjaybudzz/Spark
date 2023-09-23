require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'associations test' do
    it { should belong_to(:topic) }
    it { should have_many(:quiz_items).dependent(:destroy) }
    it { should have_one(:answer_sheet).dependent(:destroy) }
    it { should have_many(:users).through(:answer_sheet) }

    context 'destroyed quiz should destroy linked quiz items' do
      let(:sample_quiz) { create(:quiz_with_quiz_items) }

      before { sample_quiz.destroy }

      it { expect(QuizItem.count).to eq(0) }
    end

    context 'automatically create an answersheet if user and quiz exists' do
      before do
        @quiz = create(:quiz)
      end

      it { expect(@quiz.create_answer_sheet).to eq(@quiz.answer_sheet) }
    end
  end

  describe 'difficulty validation' do
    it { should validate_presence_of(:difficulty) }
  end

  describe 'score validations' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score) }
  end
end
