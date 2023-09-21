require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'associations test' do
    it { should belong_to(:topic) }
  end

  describe 'difficulty validation' do
    it { should validate_presence_of(:difficulty) }
  end

  describe 'score validations' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score) }
  end
end
