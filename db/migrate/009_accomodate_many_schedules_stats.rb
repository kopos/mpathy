class AccomodateManySchedulesStats < ActiveRecord::Migration
  def self.up
    rename_table  :campaign_schedule, :campaign_schedules

    remove_column "campaign_stats",   :num_zones
    remove_column "campaign_stats",   :num_discoveries
    remove_column "campaign_stats",   :num_accepts
    remove_column "campaign_stats",   :num_rejects
    remove_column "campaign_stats",   :num_deliveries
    remove_column "campaign_stats",   :num_failures
  
    add_column    "campaign_stats",   :type,   :string,  :null => false
    add_column    "campaign_stats",   :count,  :integer, :default => 0
  end

  def self.down
    rename_table  :campaign_schedules,:campaign_schedule

    add_column "campaign_stats",   :num_zones,       :integer
    add_column "campaign_stats",   :num_discoveries, :integer
    add_column "campaign_stats",   :num_accepts, :integer
    add_column "campaign_stats",   :num_rejects, :integer
    add_column "campaign_stats",   :num_deliveries, :integer
    add_column "campaign_stats",   :num_failures, :integer
  
    remove_column    "campaign_stats",   :type
    remove_column    "campaign_stats",   :count

  end
end
