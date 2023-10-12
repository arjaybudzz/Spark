class CreatePostDownVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_down_votes do |t|
      t.boolean :is_clicked
      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
