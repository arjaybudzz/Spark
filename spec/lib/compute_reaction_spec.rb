require 'rails_helper'

RSpec.describe ComputeReaction do
  setup do
    @post = create(:post)
  end

  describe 'user upvotes a post' do
    before do
      create_list(:post_up_vote, 10, post_id: @post.id)
      ComputeReaction.compute_upvote(@post)
    end

    it { expect(@post.upvote).to eq(10) }
  end

  describe 'user cancels his/her upvote' do
    let(:sample_upvote) { create(:post_up_vote, post_id: @post.id) }
    before do
      sample_upvote.destroy
      ComputeReaction.compute_upvote(@post)
    end

    it { expect(@post.upvote).to eq(0) }
  end
end
