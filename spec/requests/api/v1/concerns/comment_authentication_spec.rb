require 'rails_helper'

RSpec.describe CommentAuthentication do
  setup do
    @comment = create(:comment)
    @authentication = MockController.new
  end

  describe 'should get comment from comment token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(comment_id: @comment.id)
    end

    it { expect(@authentication.current_comment.id).to match(@comment.id) }
  end

  describe 'should not get comment if comment token is empty' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_comment.nil?).to eq(true) }
  end
end
