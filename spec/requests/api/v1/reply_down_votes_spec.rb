require 'rails_helper'

RSpec.describe "Api::V1::ReplyDownVotes", type: :request do
  setup do
    @reply = create(:reply)
  end

  describe "POST /create" do
    context 'user downvotes a post' do
      before do
        post api_v1_reply_down_votes_url,
          headers: { Authorization: JsonWebToken.encode(reply_id: @reply.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@reply, ReplyDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his/her downvote' do
      let(:sample_downvote) { create(:reply_down_vote, reply_id: @reply.id) }

      before do
        delete api_v1_reply_down_vote_url(sample_downvote),
          headers: { Authorization: JsonWebToken.encode(reply_id: @reply.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@reply, ReplyDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
