class ChangeDefaultValueToQuizItemsPoint < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quiz_items, :point, from: 0, to: 1
  end
end
