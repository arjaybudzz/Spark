class ChangeColumnDefaultToQuizItemsPoint < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quiz_items, :point, from: nil, to: 0
  end
end
