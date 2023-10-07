class RemoveForeignKeyToSubjects < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :subjects, column: :admin_id
  end
end
