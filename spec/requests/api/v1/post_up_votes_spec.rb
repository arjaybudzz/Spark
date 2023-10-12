require 'rails_helper'

RSpec.describe "Api::V1::PostUpVotes", type: :request do
  setup do
    @post = create(:post)
    @post_up_vote = create(:post_up_vote)
  end

  describe 'POST /create' do
    context 'user upvotes a post' do
      before do
        post api_v1_post_up_votes_url,
          headers: { Authorization: JsonWebToken.encode(post_id: @post.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_upvote(@post)).to eq(true) }
      it { expect(@post.upvote).to eq(1) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his/her upvote' do
      before do
        delete api_v1_post_up_vote_url(@post_up_vote),
          headers: { Authorization: JsonWebToken.encode(post_id: @post_up_vote.post_id) },
          as: :json
      end

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
