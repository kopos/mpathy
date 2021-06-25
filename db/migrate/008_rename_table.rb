class RenameTable < ActiveRecord::Migration
  def self.up
    rename_table :campaign_files, :campaign_assets
  end

  def self.down
    rename_table :campaign_assets, :campaign_files
  end
end
