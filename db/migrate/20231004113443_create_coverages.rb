class CreateCoverages < ActiveRecord::Migration[7.0]
  def change
    create_table :coverages do |t|
      t.string :name
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
