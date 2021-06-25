class RenameReservedColumnNames < ActiveRecord::Migration
  def self.up
		rename_column "assets", :type, :media
  end

  def self.down
		rename_column "assets", :media, :type
  end
end
