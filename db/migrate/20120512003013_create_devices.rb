class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :path, limit: 128, null: false
      t.string :dev_path, limit: 64, null: false
    end
    
    add_index :devices, [:dev_path], unique: true, null: false
  end
end
