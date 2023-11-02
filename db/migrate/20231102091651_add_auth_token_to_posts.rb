class AddAuthTokenToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :auth_token, :string
  end
end
