class ResizeColumns < ActiveRecord::Migration
  def self.up
    change_column :campaigns, :name, :string, :limit => 50
    change_column :campaigns, :code, :string, :limit => 24
  end

  def self.down
    change_column :campaigns, :name, :string, :limit => 20
    change_column :campaigns, :code, :string, :limit => 8
  end
end
