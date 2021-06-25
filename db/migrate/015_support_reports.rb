class SupportReports < ActiveRecord::Migration
  def self.up
    add_column "logs", :timestamp, :timestamp, :null => false
  end

  def self.down
    remove_column "logs", :timestamp
  end
end
