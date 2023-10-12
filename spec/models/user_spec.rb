require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association validations' do
    it { should belong_to(:admin) }
    it { should have_many(:answer_sheets).dependent(:destroy) }
    it { should have_many(:quizzes).through(:answer_sheets) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:post_up_votes).through(:posts) }
    it { should have_many(:post_down_votes).through(:posts) }
  end

  describe 'credibility validations' do
    it { should validate_presence_of(:credibility) }
  end
end
