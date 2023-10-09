class AddUserNameToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :user_name, :string
  end
end
