class AddForeignKeyToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :subjects, :subject_coverage, foreign_key: true
  end
end
