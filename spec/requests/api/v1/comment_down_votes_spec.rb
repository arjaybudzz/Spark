require 'rails_helper'

RSpec.describe "Api::V1::CommentDownVotes", type: :request do

  setup do
    @comment = create(:comment)
  end

  describe "POST /create" do
    context 'user downvotes a post' do
      before do
        post api_v1_comment_down_votes_url,
          headers: { Authorization: JsonWebToken.encode(comment_id: @comment.id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@comment, CommentDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:created) }
    end
  end

  describe 'DELETE /destroy' do
    context 'user cancels his/her downvote' do
      let(:sample_downvote) { create(:comment_down_vote, comment_id: @comment.id) }

      before do
        delete api_v1_comment_down_vote_url(sample_downvote),
          headers: { Authorization: JsonWebToken.encode(comment_id: sample_downvote.comment_id) },
          as: :json
      end

      it { expect(ComputeReaction.compute_downvote(@comment, CommentDownVote.count)).to eq(true) }
      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
