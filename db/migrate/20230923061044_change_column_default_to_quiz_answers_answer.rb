class ChangeColumnDefaultToQuizAnswersAnswer < ActiveRecord::Migration[7.0]
  def change
    change_column_default :quiz_answers, :answer, from: nil, to: 'unknown'
  end
end
