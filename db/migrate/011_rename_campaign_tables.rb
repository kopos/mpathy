class RenameCampaignTables < ActiveRecord::Migration
  def self.up
	rename_table "campaign_assets", 		"assets"
	rename_table "campaign_logs",    		"logs"
	rename_table "campaign_schedules", "schedules"
	rename_table "campaign_stats",   		"stats"
  end

  def self.down
  	rename_table "assets", 		"campaign_assets"
	rename_table "logs", 			"campaign_logs"
	rename_table "schedules", "campaign_schedules"
	rename_table "stats",		"campaign_stats"
  end
end
