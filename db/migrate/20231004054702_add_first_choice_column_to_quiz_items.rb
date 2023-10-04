class AddFirstChoiceColumnToQuizItems < ActiveRecord::Migration[7.0]
  def change
    add_column :quiz_items, :first_choice, :string
  end
end
