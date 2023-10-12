require 'rails_helper'

RSpec.describe PostUpVote, type: :model do
  describe 'associations validations' do
    it { should belong_to(:post) }
  end

  describe 'is clicked validations' do
    it { should validate_presence_of(:is_clicked) }
  end
end
