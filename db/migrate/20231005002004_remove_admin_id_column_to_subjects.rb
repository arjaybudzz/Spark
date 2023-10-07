class RemoveAdminIdColumnToSubjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :subjects, :admin_id
  end
end
