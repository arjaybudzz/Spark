require 'rails_helper'

RSpec.describe 'Api::V1::SubjectCoverageTokens', type: :request do
  setup do
    @subject_coverage = create(:subject_coverage)
  end

  describe 'POST /create' do
    context 'create a token if input is correct' do
      let(:coverage_attribute) { attributes_for(:subject_coverage) }

      before do
        post api_v1_subject_coverage_tokens_url,
            params: { subject_coverage: coverage_attribute },
            as: :json
      end

      it { expect(json[:coverage_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not create a token if input is wrong' do
      let(:coverage_attribute) { attributes_for(:wrong_name) }

      before do
        post api_v1_subject_coverage_tokens_url,
            params: { subject_coverage: coverage_attribute },
            as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
