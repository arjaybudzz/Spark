require 'rails_helper'

RSpec.describe CommentUpVote, type: :model do
  describe 'associations validations' do
    it { should belong_to(:comment) }
  end
end
