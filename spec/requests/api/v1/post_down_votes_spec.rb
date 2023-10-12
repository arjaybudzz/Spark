require 'rails_helper'

RSpec.describe "Api::V1::PostDownVotes", type: :request do
  setup do
    @post = create(:post)
  end

  describe "POST /create" do
    context 'user downvotes a post' do
      before do
        post api_v1_post_down_votes_url,
          headers: { Authorization: JsonWebToken.encode(post_id: @post.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@post, PostDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his/her downvote' do
      let(:sample_downvote) { create(:post_down_vote, post_id: @post.id) }

      before do
        delete api_v1_post_down_vote_url(sample_downvote),
          headers: { Authorization: JsonWebToken.encode(post_id: sample_downvote.post_id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@post, PostDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
