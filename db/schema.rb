# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120512030619) do

  create_table "blocks", :force => true do |t|
    t.integer "device_id"
    t.integer "owner_id"
    t.integer "node0_id"
    t.integer "serial"
  end

  add_index "blocks", ["device_id", "owner_id"], :name => "index_blocks_on_device_id_and_owner_id"
  add_index "blocks", ["node0_id", "serial"], :name => "index_blocks_on_node0_id_and_serial", :unique => true
  add_index "blocks", ["owner_id"], :name => "index_blocks_on_owner_id"

  create_table "config_vars", :force => true do |t|
    t.string "name",  :null => false
    t.binary "value", :null => false
  end

  add_index "config_vars", ["name"], :name => "index_config_vars_on_name", :unique => true

  create_table "credentials", :force => true do |t|
    t.integer "user_id",                                    :null => false
    t.string  "type",     :limit => 32,                     :null => false
    t.string  "name",     :limit => 128
    t.boolean "verified",                :default => false, :null => false
    t.binary  "key"
  end

  add_index "credentials", ["type", "name"], :name => "index_credentials_on_type_and_name", :unique => true
  add_index "credentials", ["user_id", "type"], :name => "index_credentials_on_user_id_and_type"

  create_table "devices", :force => true do |t|
    t.string "path",     :limit => 128, :null => false
    t.string "dev_path", :limit => 64,  :null => false
  end

  add_index "devices", ["dev_path"], :name => "index_devices_on_dev_path", :unique => true

  create_table "nodes", :force => true do |t|
    t.string   "type",       :limit => 16, :null => false
    t.integer  "size",                     :null => false
    t.integer  "block0_id",                :null => false
    t.integer  "owner_id",                 :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "nodes", ["block0_id"], :name => "index_nodes_on_block0_id"
  add_index "nodes", ["owner_id"], :name => "index_nodes_on_owner_id"

  create_table "users", :force => true do |t|
    t.string   "exuid",      :limit => 32,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "admin",                    :default => false, :null => false
  end

  add_index "users", ["exuid"], :name => "index_users_on_exuid", :unique => true

end
