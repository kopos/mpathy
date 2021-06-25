class Log < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :status
end
