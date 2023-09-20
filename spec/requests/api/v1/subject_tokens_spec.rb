require 'rails_helper'

RSpec.describe 'Api::V1::SubjectTokens', type: :request do
  setup do
    @subject = create(:sample_subject)
  end

  describe 'POST /create' do
    context 'should generate token if subject is created' do
      let(:subject_attribute) { attributes_for(:sample_subject) }

      before do
        post api_v1_subject_tokens_url,
          params: { subject: subject_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'should not generate token if subject is not created' do
      let(:subject_attribute) { attributes_for(:invalid_subject) }

      before do
        post api_v1_subject_tokens_url,
          params: { subject: subject_attribute },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
