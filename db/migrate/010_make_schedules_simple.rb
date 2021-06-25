class MakeSchedulesSimple < ActiveRecord::Migration  
  def self.up
    remove_column "campaign_schedules", :start
    remove_column "campaign_schedules", :end
    remove_column "campaign_schedules", :start_time
    remove_column "campaign_schedules", :end_time

    add_column    "campaign_schedules", :startdate, :date
    add_column    "campaign_schedules", :enddate,   :date
    add_column    "campaign_schedules", :starttime, :time
    add_column    "campaign_schedules", :endtime,   :time
  end

  def self.down
    add_column "campaign_schedules", :start,      :datetime
    add_column "campaign_schedules", :end,        :datetime
    add_column "campaign_schedules", :start_time, :datetime
    add_column "campaign_schedules", :end_time,   :datetime

    remove_column    "campaign_schedules", :startdate
    remove_column    "campaign_schedules", :enddate
    remove_column    "campaign_schedules", :starttime
    remove_column    "campaign_schedules", :endtime

  end
end
