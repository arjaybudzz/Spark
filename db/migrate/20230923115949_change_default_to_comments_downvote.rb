class ChangeDefaultToCommentsDownvote < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :downvote, from: nil, to: 0
  end
end
