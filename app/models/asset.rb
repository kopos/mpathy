class Asset < ActiveRecord::Base
  belongs_to :campaign

  validates_presence_of :name
  validates_presence_of :path
  validates_presence_of :type     # movie, mp3, font, coupon
  validates_presence_of :purpose  # download, play/show/screen
  validates_uniqueness_of :name

  def self.purposes
    ['download', 'play', 'both'].collect { |p| [p, p] }
  end

  def self.types
    ['video', 'audio', 'image', 'coupon', 'executable', 'file'].collect {|t| [t, t] }
  end 
end
