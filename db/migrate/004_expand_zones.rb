class ExpandZones < ActiveRecord::Migration
  def self.up
    add_column "zones", :alias, :string
    add_column "zones", :description, :string
  end

  def self.down
    remove_column "zones", :alias
    remove_column "zones", :description
  end
end
