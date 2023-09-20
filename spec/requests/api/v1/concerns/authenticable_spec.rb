require 'rails_helper'

RSpec.describe Authenticable do
  setup do
    @admin = create(:admin)
    @authentication = MockController.new
  end

  describe 'should get admin from authentication token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(admin_id: @admin.id)
    end

    it { expect(@authentication.current_admin.id).to match(@admin.id) }
  end

  describe 'should not get admin if unauthorized' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_admin.nil?).to eq(true) }
  end
end
