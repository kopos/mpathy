class MakeSchedulesSimpler < ActiveRecord::Migration  
  
	def self.up
    add_column "schedules", :start,      :datetime
    add_column "schedules", :end,        :datetime

    remove_column    "schedules", :startdate
    remove_column    "schedules", :enddate
    remove_column    "schedules", :starttime
    remove_column    "schedules", :endtime
  end

  def self.down
    remove_column "schedules", :start
    remove_column "schedules", :end

    add_column    "schedules", :startdate, :date
    add_column    "schedules", :enddate,   :date
    add_column    "schedules", :starttime, :time
    add_column    "schedules", :endtime,   :time
  end

end
