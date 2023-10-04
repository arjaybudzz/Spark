class AddSecondChoiceToQuizItems < ActiveRecord::Migration[7.0]
  def change
    add_column :quiz_items, :second_choice, :string
  end
end
