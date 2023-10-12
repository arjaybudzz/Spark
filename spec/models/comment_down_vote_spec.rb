require 'rails_helper'

RSpec.describe CommentDownVote, type: :model do
  describe 'association validation' do
    it { should belong_to(:comment) }
  end
end
