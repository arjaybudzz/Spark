class ChangeDefaultValueToQuizzesScore < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quizzes, :score, from: 0, to: 10
  end
end
