require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'association validations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:post_up_votes).dependent(:destroy) }
  end

  describe 'body associations' do
    it { should validate_presence_of(:body) }
  end

  describe 'upvote validation' do
    it { should validate_numericality_of(:upvote).is_greater_than_or_equal_to(0) }
  end

  describe 'downvote validation' do
    it { should validate_numericality_of(:downvote).is_greater_than_or_equal_to(0) }
  end
end
