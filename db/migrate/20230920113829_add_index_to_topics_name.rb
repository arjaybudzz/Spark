class AddIndexToTopicsName < ActiveRecord::Migration[7.0]
  def change
    add_index :topics, :name, unique: true
  end
end
