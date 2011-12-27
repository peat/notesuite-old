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

ActiveRecord::Schema.define(:version => 20110718180601) do

  create_table "authorities", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorities", ["name"], :name => "index_authorities_on_name"
  add_index "authorities", ["region_id"], :name => "index_authorities_on_country_id"

  create_table "currencies", :force => true do |t|
    t.string   "unit",         :null => false
    t.integer  "region_id",    :null => false
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authority_id"
  end

  add_index "currencies", ["authority_id"], :name => "index_currencies_on_authority_id"
  add_index "currencies", ["region_id"], :name => "index_currencies_on_country_id"
  add_index "currencies", ["unit"], :name => "index_currencies_on_unit"

  create_table "grades", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "full_name",   :null => false
    t.text     "description"
    t.integer  "rank",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["rank"], :name => "index_grades_on_rank"

  create_table "masters", :force => true do |t|
    t.integer  "currency_id",            :null => false
    t.string   "code"
    t.decimal  "denomination",           :null => false
    t.text     "description"
    t.integer  "overprint_currency_id"
    t.decimal  "overprint_denomination"
    t.date     "issued_on"
    t.date     "printed_on"
    t.date     "withdrawn_on"
    t.date     "lapsed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "printer_id"
  end

  add_index "masters", ["code"], :name => "index_masters_on_code"
  add_index "masters", ["currency_id"], :name => "index_masters_on_currency_id"
  add_index "masters", ["denomination"], :name => "index_masters_on_denomination"
  add_index "masters", ["issued_on"], :name => "index_masters_on_issued_on"
  add_index "masters", ["printer_id"], :name => "index_masters_on_printer_id"

  create_table "notes", :force => true do |t|
    t.integer  "master_id",                      :null => false
    t.date     "printed_on"
    t.string   "serial"
    t.text     "description"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "replacement", :default => false
    t.boolean  "specimen",    :default => false, :null => false
  end

  add_index "notes", ["grade_id"], :name => "index_notes_on_grade_id"
  add_index "notes", ["master_id"], :name => "index_notes_on_master_id"
  add_index "notes", ["serial"], :name => "index_notes_on_serial"

  create_table "printers", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "region_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "printers", ["region_id"], :name => "index_printers_on_region_id"

  create_table "regions", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "native_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "ancestry"
  end

  add_index "regions", ["ancestry"], :name => "index_regions_on_ancestry"
  add_index "regions", ["name"], :name => "index_countries_on_name"
  add_index "regions", ["parent_id"], :name => "index_regions_on_parent_id"

end
