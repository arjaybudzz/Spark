class ChangeColumnDefaultToCommentUpVotesIsClicked < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comment_up_votes, :is_clicked, from: nil, to: true
  end
end
