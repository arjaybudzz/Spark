class ChangeColumnDefaultToAnswerSheetsScore < ActiveRecord::Migration[7.0]
  def change
    change_column_default :answer_sheets, :score, from: nil, to: 0
  end
end
