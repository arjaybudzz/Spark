require 'rails_helper'

RSpec.describe ReplyAuthentication do
  setup do
    @reply = create(:reply)
    @authentication = MockController.new
  end

  describe 'will get reply from authentication token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(reply_id: @reply.id)
    end

    it { expect(@authentication.current_reply.id).to match(@reply.id) }
  end

  describe 'will not get reply if token is empty' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_reply.nil?).to eq(true) }
  end
end
