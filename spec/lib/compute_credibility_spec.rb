require 'rails_helper'

RSpec.describe ComputeCredibility do
  setup do
    @user = create(:user_with_posts)
    @user_with_downvote_posts = create(:user_with_downvote_posts)
  end

  describe 'all posts are upvotes' do
    before do
      ComputeCredibility.compute(@user)
    end

    it { expect(@user.credibility).to eq(1) }
  end

  describe 'all posts are downvotes' do
    before do
      ComputeCredibility.compute(@user_with_downvote_posts)
    end

    it { expect(@user_with_downvote_posts.credibility).to eq(0) }
  end
end
