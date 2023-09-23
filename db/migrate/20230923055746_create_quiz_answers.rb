class CreateQuizAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :quiz_answers do |t|
      t.string :answer
      t.belongs_to :quiz_item, null: false, foreign_key: true
      t.belongs_to :answer_sheet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
