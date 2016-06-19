class Location < ActiveRecord::Base
  belongs_to :profile

  validates_presence_of :profile_id
  validates :profile_id, numericality: {only_integer: true}

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
end
