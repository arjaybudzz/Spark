class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :upvote
      t.integer :downvote
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
