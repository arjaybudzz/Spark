require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'associations test' do
    it { should belong_to(:admin) }
  end

  describe 'subject name validation' do
    it { should validate_presence_of(:name) }
  end
end
