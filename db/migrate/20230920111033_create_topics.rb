class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :discussion
      t.belongs_to :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
