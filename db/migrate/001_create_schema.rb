class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table "campaigns" do |t|
      t.string :name,         :limit => 20    ,:null  => false
      t.string :alias,        :limit => 8     ,:null  => false
      t.text   :notes,        :limit => 250
      t.string :status,       :limit => 16
      t.timestamps
    end

    create_table "campaign_files" do |t|
      t.string  :name,        :limit => 40    , :null => false
      t.string  :path,        :limit => 250   , :null => false
      t.string  :type,        :default => "movie" 
      t.string  :purpose,     :default => "download"
    end

    create_table "campaign_zones" do |t|
      t.integer :campaign_id, :null  => false
      t.integer :zone_id
      t.integer :beamer_id
    end

    create_table "campaign_schedule" do |t|
      t.timestamp :start
      t.timestamp :end
      t.boolean   :recurring
      t.integer   :interval
      t.timestamp :start_time
      t.timestamp :end_time
    end

    create_table "campaign_stats" do |t|
      t.integer   :campaign_id
      t.integer   :num_zones
      t.integer   :num_discoveries
      t.integer   :num_accepts
      t.integer   :num_rejects
      t.integer   :num_deliveries
      t.integer   :num_failures
    end

    create_table "campaign_logs" do |t|
      t.integer   :campaign_id
      t.integer   :zone_id
      t.integer   :beamer_id
      t.string    :phone_mac_add
      t.string    :status
    end

    create_table "zones" do |t|
      t.string :name,         :null  => false
    end

    create_table "beamers" do |t|
      t.string :geolocation_id
      t.string :alias
      t.string :auth_code,    :limit => 15
    end
    
    create_table "geolocations" do |t|
      t.string :name
      t.string :lat
      t.string :long
    end
    
    create_table "zone_beamers" do |t|
      t.integer :zone_id
      t.integer :beamer_id
    end 
  end

  def self.down
    drop_table :campaigns
    drop_table :campaign_logs
    drop_table :campaign_files
    drop_table :campaign_schedule
    drop_table :campaign_stats
    drop_table :campaign_zones
    drop_table :beamers
    drop_table :geolocations
    drop_table :zones
    drop_table :zone_beamers

  end
end
