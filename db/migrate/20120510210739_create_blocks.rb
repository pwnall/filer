class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :path, limit: 128, null: false
      t.references :owner, null: true
      t.references :node0, null: true
      t.integer :serial, null: false, default: 0
    end
  end
end
