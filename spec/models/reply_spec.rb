require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe 'associations validation' do
    it { should belong_to(:comment) }
  end

  describe 'user name validations' do
    it { should validate_presence_of(:user_name) }
  end
end
