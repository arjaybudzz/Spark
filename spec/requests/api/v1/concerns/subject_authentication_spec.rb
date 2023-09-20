require 'rails_helper'

RSpec.describe SubjectAuthentication do
  setup do
    @subject = create(:subject)
    @authentication = MockController.new
  end

  describe 'should get subject from token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(subject_id: @subject.id)
    end

    it { expect(@authentication.current_subject.id).to match(@subject.id) }
  end

  describe 'should not get subject from token if it does not exist' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_subject.nil?).to eq(true) }
  end
end
