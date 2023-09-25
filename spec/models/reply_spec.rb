require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe 'associations validation' do
    it { should belong_to(:comment) }
  end
end
