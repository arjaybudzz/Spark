require 'rails_helper'

RSpec.describe QuizItem, type: :model do
  describe 'associations test' do
    it { should belong_to(:quiz) }
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
