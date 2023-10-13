require 'rails_helper'

RSpec.describe "Api::V1::ReplyUpVotes", type: :request do
  setup do
    @reply = create(:reply)
  end

  describe "POST /create" do
    context 'user upvotes a reply' do
      before do
        post api_v1_reply_up_votes_url,
          headers: { Authorization: JsonWebToken.encode(reply_id: @reply.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_upvote(@reply, ReplyUpVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his upvote/downvote' do
      let(:sample_upvote) { create(:reply_up_vote, reply_id: @reply.id) }

      before do
        delete api_v1_reply_up_vote_url(sample_upvote),
          headers: { Authorization: JsonWebToken.encode(reply_id: sample_upvote.reply_id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_upvote(@reply, ReplyUpVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
