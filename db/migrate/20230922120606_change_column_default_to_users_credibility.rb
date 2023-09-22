class ChangeColumnDefaultToUsersCredibility < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :credibility, from: nil, to: 0
  end
end
