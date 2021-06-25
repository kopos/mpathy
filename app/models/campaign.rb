class Campaign < ActiveRecord::Base
  has_many :stats
  has_many :assets
  has_many :logs
  has_many :schedules
  has_and_belongs_to_many :zones 
  
  validates_presence_of :name, :code
  validates_length_of   :name, :within => 6..50
  validates_length_of   :code, :within => 4..24

  def self.active_campaigns_cnt
    Campaign.count(:id, :conditions => "status = 'active'")
  end

  def self.nonactive_campaigns_cnt
    Campaign.count(:id, :conditions => "status != 'active'")
  end

  def self.inactive_campaigns_cnt
    Campaign.count(:id, :conditions => "status = 'inactive'")
  end
  
  def self.closed_campaigns_cnt
    Campaign.count(:id, :conditions => "status = 'closed'")
  end
 
  def self.find_by_code(code)
    find :first, :condition => [":code = ?", code]
  end

  def self.statuses
    statuses = [:active, :inactive, :closed].collect { |s| [s, s] }
  end
  
  def active?
    status == "active"
  end

  def inactive?
    status == "inactive"
  end
 
  def closed?
    status == "closed"
  end
end
