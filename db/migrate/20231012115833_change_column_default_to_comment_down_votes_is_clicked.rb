class ChangeColumnDefaultToCommentDownVotesIsClicked < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comment_down_votes, :is_clicked, from: nil, to: true
  end
end
