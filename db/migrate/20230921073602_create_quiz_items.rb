class CreateQuizItems < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_items do |t|
      t.text :problem
      t.string :answer
      t.integer :point
      t.belongs_to :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
