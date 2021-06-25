class ResolveNameConflicts < ActiveRecord::Migration
  def self.up
    rename_column "campaigns", :alias, :code
  end

  def self.down
  end
end
