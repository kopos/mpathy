class Geolocation < ActiveRecord::Base
  def self.based_on_table?
    false
  end
end
