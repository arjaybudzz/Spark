require 'rails_helper'

RSpec.describe PostAuthentication do
  setup do
    @post = create(:post)
    @authentication = MockController.new
  end

  describe 'should get post from post token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(post_id: @post.id)
    end

    it { expect(@authentication.current_post.id).to match(@post.id) }
  end

  describe 'should not get post if there is no token' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_post.nil?).to eq(true) }
  end
end
