class RemoveIdColsForJoins < ActiveRecord::Migration
  def self.up
    remove_column "beamers_zones",   :id
    remove_column "campaigns_zones", :id
  end

  def self.down
    add_column "beamers_zones", :id, :integer
    add_column "campaigns_zones", :id, :integer
  end
end
