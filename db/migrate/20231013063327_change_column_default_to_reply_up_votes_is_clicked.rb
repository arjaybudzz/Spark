class ChangeColumnDefaultToReplyUpVotesIsClicked < ActiveRecord::Migration[7.0]
  def change
    change_column_default :reply_up_votes, :is_clicked, from: nil, to: true
  end
end
