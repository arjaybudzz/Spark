require 'rails_helper'

RSpec.describe QuizAuthentication do
  setup do
    @quiz = create(:quiz)
    @authentication = MockController.new
  end

  describe 'should get quiz from quiz token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(quiz_id: @quiz.id)
    end

    it { expect(@authentication.current_quiz.id).to match(@quiz.id) }
  end

  describe 'should not quiz if does not exist' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_quiz.nil?).to eq(true) }
  end
end
