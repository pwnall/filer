class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :path, limit: 128, null: false
      t.references :owner, null: true
      t.references :node0, null: true
      t.integer :serial, null: false, default: 0
    end
    
    add_index :blocks, [:node0_id, :serial], null: true, unique: true
    add_index :blocks, [:owner_id], null: true, unique: false
  end
end
