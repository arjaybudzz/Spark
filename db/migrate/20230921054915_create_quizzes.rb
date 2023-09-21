class CreateQuizzes < ActiveRecord::Migration[7.0]
  def change
    create_table :quizzes do |t|
      t.string :difficulty
      t.integer :score
      t.belongs_to :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
