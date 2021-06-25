class Schedule < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :start, :end
end
