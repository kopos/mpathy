# forgot to add the campaign_id as the foreign key in some
# of the campaign_ tables.
#  campaign_schedule
#  campaign_files
class AddCampaignFk < ActiveRecord::Migration
  def self.up
    add_column :campaign_schedule, :campaign_id, :integer, :null => false
    add_column :campaign_files,    :campaign_id, :integer, :null => false
  end
  

  def self.down
  end
end
