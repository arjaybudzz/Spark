require 'rails_helper'

RSpec.describe 'Api::V1::TopicTokens', type: :request do
  setup do
    @topic = create(:sample_topic)
  end

  describe 'POST /create' do
    context 'generate token if topic is found' do
      let(:topic_sample) { attributes_for(:sample_topic) }

      before do
        post api_v1_topic_tokens_url,
          params: { topic: topic_sample },
          as: :json
      end

      it { expect(json[:topic_token].nil?).to eq(false) }
      it { expect(response).to have_http_status(:success) }
    end

    context 'do not generate token if topic is not found' do
      let(:topic_sample) { attributes_for(:quadratic_equation_topic) }

      before do
        post api_v1_topic_tokens_url,
          params: { topic: topic_sample },
          as: :json
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
