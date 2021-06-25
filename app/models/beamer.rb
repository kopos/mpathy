class Beamer < ActiveRecord::Base
  has_and_belongs_to_many :zones

  def location
    if self.geolocation_id.nil?
      location_name
    else
      location = Geolocation.find(self.geolocation_id)
      location.name
    end
  end

  def location=(val)
    location = Geolocation.find_by_name(val)
    if location.nil?
      self.location_name = val
    else
      self.geolocation_id = location.id
    end
  end
 
  def self.ActionMappings
	  {	"success" => 'Obex Push Completed',
		  "rejected"=> 'Obex Push Rejected',
			"failed"  => 'Obex Push Incomplete'}
  end
 
  # The action hash is of the following format
  #
	# - Obex Push Completed: 1208029347
	# - Obex Push Incomplete: 1208029388
	# - Obex Push Rejected: 1208029367
  def self.get_action_info data_hash
		Beamer.ActionMappings.each do |status, message| 
		  return data_hash[message], status unless data_hash[message].nil?
		end
  end

end
