require 'rails_helper'

RSpec.describe "Api::V1::CommentUpVotes", type: :request do
  setup do
    @comment = create(:comment)
  end

  describe 'POST /create' do
    context 'user upvotes a comment' do
      before do
        post api_v1_comment_up_votes_url,
          headers: { Authorization: JsonWebToken.encode(comment_id: @comment.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_upvote(@comment, CommentUpVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his/her upvote' do
      let(:upvote_sample) { create(:comment_up_vote, comment_id: @comment.id) }

      before do
        delete api_v1_comment_up_vote_url(upvote_sample),
          headers: { Authorization: JsonWebToken.encode(comment_id: upvote_sample.comment_id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_upvote(@comment, CommentUpVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
