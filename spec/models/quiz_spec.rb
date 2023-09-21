require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'associations test' do
    it { should belong_to(:topic) }
    it { should have_many(:quiz_items).dependent(:destroy) }

    context 'destroyed quiz should destroy linked quiz items' do
      let(:sample_quiz) { create(:quiz_with_quiz_items) }

      before { sample_quiz.destroy }

      it { expect(QuizItem.count).to eq(0) }
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
