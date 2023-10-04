class AddFourthChoiceToQuizItems < ActiveRecord::Migration[7.0]
  def change
    add_column :quiz_items, :fourth_choice, :string
  end
end
