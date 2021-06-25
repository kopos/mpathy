class Zone < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :beamers

  validates_presence_of   :name
  validates_length_of     :name, :within => 6..255
end
