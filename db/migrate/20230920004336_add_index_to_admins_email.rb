class AddIndexToAdminsEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :admins, :email, unique: true
  end
end
