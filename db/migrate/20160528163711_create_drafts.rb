class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.string :name, null: false
      t.integer :year, null:false
      t.string  :venue
      t.timestamps null: false
    end
    add_index :drafts, :year, :unique => true
  end
end
