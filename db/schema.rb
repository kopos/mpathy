# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 16) do

  create_table "assets", :force => true do |t|
    t.string  "name",        :limit => 40,  :default => "",         :null => false
    t.string  "path",        :limit => 250, :default => "",         :null => false
    t.string  "media"
    t.string  "purpose",                    :default => "download"
    t.integer "campaign_id",                                        :null => false
    t.string  "url"
  end

  create_table "beamers", :force => true do |t|
    t.string "geolocation_id"
    t.string "alias"
    t.string "auth_code",      :limit => 15
    t.string "location_name"
  end

  create_table "beamers_zones", :id => false, :force => true do |t|
    t.integer "zone_id"
    t.integer "beamer_id"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name",       :limit => 50, :default => ""
    t.string   "code",       :limit => 24
    t.text     "notes"
    t.string   "status",     :limit => 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns_zones", :id => false, :force => true do |t|
    t.integer "campaign_id", :null => false
    t.integer "zone_id"
    t.integer "beamer_id"
  end

  create_table "geolocations", :force => true do |t|
    t.string "name"
    t.string "lat"
    t.string "long"
  end

  create_table "logs", :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "zone_id"
    t.integer  "beamer_id"
    t.string   "phone_mac_add"
    t.string   "status"
    t.datetime "timestamp",     :null => false
  end

  create_table "schedules", :force => true do |t|
    t.boolean  "recurring"
    t.integer  "interval"
    t.integer  "campaign_id", :null => false
    t.datetime "start"
    t.datetime "end"
  end

  create_table "stats", :force => true do |t|
    t.integer "campaign_id"
    t.string  "type",        :default => "", :null => false
    t.integer "count",       :default => 0
  end

  create_table "zones", :force => true do |t|
    t.string "name",        :default => "", :null => false
    t.string "alias"
    t.string "description"
  end

end
