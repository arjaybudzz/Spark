require 'rails_helper'

RSpec.describe ReplyDownVote, type: :model do
  describe 'association validations' do
    it { should belong_to(:reply) }
  end
end
