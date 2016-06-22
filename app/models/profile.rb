class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :location

  def self.search_names(search)
    where("name LIKE ?", "%#{search}%")
  end

  def self.search_ages(search)
    where("age LIKE ?", "%#{search}%")
  end
  
  def self.search_genres(search)
    where("genre LIKE ?", "%#{search}%")
  end

  def self.search_availabilities(search)
    where("age LIKE ?", "%#{search}%")
  end

  def self.search_ages(search)
    where("age LIKE ?", "%#{search}%")
  end
end