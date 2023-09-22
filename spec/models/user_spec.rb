require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association validations' do
    it { should belong_to(:admin) }
  end

  describe 'credibility validations' do
    it { should validate_presence_of(:credibility) }
  end
end
