class RenameTablesForAssoc < ActiveRecord::Migration
  def self.up
    rename_table :campaign_zones, :campaigns_zones
    rename_table :zone_beamers,   :beamers_zones
  end

  def self.down
    rename_table :campaigns_zones, :campaign_zones
    rename_table :beamers_zones,   :zone_beamers
  end
end
