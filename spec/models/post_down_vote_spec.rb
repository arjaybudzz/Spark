require 'rails_helper'

RSpec.describe PostDownVote, type: :model do
  describe 'association validations' do
    it { should belong_to(:post) }
  end
end
