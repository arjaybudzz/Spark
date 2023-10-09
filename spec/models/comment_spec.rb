require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations test' do
    it { should belong_to(:post) }
    it { should have_many(:replies).dependent(:destroy) }
  end

  describe 'user name validation' do
    it { should validate_presence_of(:user_name) }
  end
end
