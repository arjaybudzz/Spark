class CreateAnswerSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_sheets do |t|
      t.integer :score
      t.belongs_to :quiz, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
