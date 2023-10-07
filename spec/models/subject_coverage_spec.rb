require 'rails_helper'

RSpec.describe SubjectCoverage, type: :model do
  describe 'association validations' do
    it { should belong_to(:admin) }
    it { should have_many(:subjects).dependent(:destroy) }
  end

  describe 'coverage name validations' do
    it { should validate_presence_of(:name) }
  end
end
