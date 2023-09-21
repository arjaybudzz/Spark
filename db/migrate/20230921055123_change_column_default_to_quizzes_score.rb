class ChangeColumnDefaultToQuizzesScore < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quizzes, :score, from: nil, to: 0
  end
end
