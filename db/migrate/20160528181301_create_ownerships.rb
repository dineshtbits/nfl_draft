class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :draft_id, null: false
      t.integer :round, null: false
      t.integer :pick, null: false
      t.integer :team_id, null: false
      t.integer :player_id
      t.timestamps null: false
    end
    add_index :ownerships, [:draft_id, :player_id], :unique => true
  end
end
