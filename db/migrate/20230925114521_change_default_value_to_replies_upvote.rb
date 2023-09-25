class ChangeDefaultValueToRepliesUpvote < ActiveRecord::Migration[7.0]
  def change
    change_column_default :replies, :upvote, from: nil, to: 0
  end
end
