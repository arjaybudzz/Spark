require 'rails_helper'

RSpec.describe Coverage, type: :model do
  describe 'associations test' do
    it { should belong_to(:admin) }
  end

  describe 'name validations' do
    it { should validate_presence_of(:name) }
  end
end
