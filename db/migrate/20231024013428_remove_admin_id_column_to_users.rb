class RemoveAdminIdColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin_id
  end
end
