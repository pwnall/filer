class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :device, null: true
      t.references :owner, null: true
      t.references :node0, null: true
      t.integer :serial, null: false, default: 0
    end
    
    add_index :blocks, [:node0_id, :serial], null: true, unique: true
    add_index :blocks, [:device_id, :owner_id], null: true, unique: false
    add_index :blocks, [:owner_id], null: true, unique: false
  end
end
