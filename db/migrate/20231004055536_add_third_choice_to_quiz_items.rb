class AddThirdChoiceToQuizItems < ActiveRecord::Migration[7.0]
  def change
    add_column :quiz_items, :third_choice, :string
  end
end
