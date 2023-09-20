require 'rails_helper'

RSpec.describe TopicAuthentication do
  setup do
    @topic = create(:topic)
    @authentication = MockController.new
  end

  describe 'should get topic from topic token' do
    before do
      @authentication.request.headers['Authorization'] = JsonWebToken.encode(topic_id: @topic.id)
    end

    it { expect(@authentication.current_topic.id).to match(@topic.id) }
  end

  describe 'should not get topic if there is no subject' do
    before do
      @authentication.request.headers['Authorization'] = nil
    end

    it { expect(@authentication.current_topic.nil?).to eq(true) }
  end
end
