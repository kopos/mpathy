class Stat < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :type, :count
end
