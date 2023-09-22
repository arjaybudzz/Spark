require 'rails_helper'

RSpec.describe AnswerSheet, type: :model do
  describe 'association validations' do
    it { should belong_to(:user) }
    it { should belong_to(:quiz) }
  end

  describe 'score validation' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score).is_greater_than_or_equal_to(0) }
  end
end
