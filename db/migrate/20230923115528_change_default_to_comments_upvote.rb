class ChangeDefaultToCommentsUpvote < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :upvote, from: nil, to: 0
  end
end
