class AddAssetUrl < ActiveRecord::Migration
  def self.up
    add_column "assets", :url, :string
  end

  def self.down
    remove_column "assets", :url
  end
end
