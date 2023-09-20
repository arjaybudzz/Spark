class AddIndexToSubjectsName < ActiveRecord::Migration[7.0]
  def change
    add_index :subjects, :name, unique: true
  end
end
