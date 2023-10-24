class RemoveForeignKeyFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :users, column: :admin_id
  end
end
