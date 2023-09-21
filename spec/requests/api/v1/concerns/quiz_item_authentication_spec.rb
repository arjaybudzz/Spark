require 'rails_helper'

RSpec.describe QuizItemAuthentication do
  setup do
    @quiz_item = create(:quiz_item)
    @authentication = MockController.new
  end

  describe 'should get quiz item from quiz item token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(quiz_item_id: @quiz_item.id)
    end

    it { expect(@authentication.current_quiz_item.id).to match(@quiz_item.id) }
  end

  describe 'should not get quiz item if token is wrong or empty' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_quiz_item.nil?).to eq(true) }
  end
end
