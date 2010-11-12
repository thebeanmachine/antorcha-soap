# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20101111142334) do
=======
ActiveRecord::Schema.define(:version => 20101111132941) do
>>>>>>> eb766399076ae9e4b6fb0b47e3898b85f90e95da

  create_table "antorchas", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
  create_table "operations", :force => true do |t|
    t.integer  "message_id", :null => false
=======
  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
>>>>>>> eb766399076ae9e4b6fb0b47e3898b85f90e95da
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
  add_index "operations", ["message_id"], :name => "index_operations_on_message_id", :unique => true
=======
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"
>>>>>>> eb766399076ae9e4b6fb0b47e3898b85f90e95da

end
