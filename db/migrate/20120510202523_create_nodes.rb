class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :type, limit: 16, null: false
      t.integer :size, null: false
      t.references :block0, null: false
      t.references :owner, null: false

      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  
    add_index :nodes, :owner, unique: false, null: true
    add_index :nodes, :block0, unique: false, null: true
  end
end
