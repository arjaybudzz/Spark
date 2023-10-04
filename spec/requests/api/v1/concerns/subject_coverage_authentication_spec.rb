require 'rails_helper'

RSpec.describe SubjectCoverageAuthentication do
  setup do
    @subject_coverage = create(:subject_coverage)
    @authentication = MockController.new
  end

  describe 'should get coverage name from authentication token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(subject_coverage_id: @subject_coverage.id)
    end

    it { expect(@authentication.current_subject_coverage.id).to match(@subject_coverage.id) }
  end

  describe 'should not get coverage name if auth token is empty' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_subject_coverage.nil?).to eq(true) }
  end
end
