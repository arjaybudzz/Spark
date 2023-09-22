class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.decimal :credibility
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
