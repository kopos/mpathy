class AddLocationString < ActiveRecord::Migration
  def self.up
    add_column "beamers", :location_name, :string, :length => 30
  end

  def self.down
    remove_column "beamers", :location_name
  end
end
