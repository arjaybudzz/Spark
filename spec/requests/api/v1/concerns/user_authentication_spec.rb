require 'rails_helper'

RSpec.describe UserAuthentication do
  setup do
    @user = create(:user)
    @authentication = MockController.new
  end

  describe 'get user from authentication token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
    end

    it { expect(@authentication.current_user.id).to match(@user.id) }
  end

  describe 'do not get user if unauthorized' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_user.nil?).to eq(true) }
  end
end
