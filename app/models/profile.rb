class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :location

  # searchable do
  #   integer :age
  #   string :name
  #   string :gender
  #   string :phone_number
  #   string :genre
  #   string :availability
  # end
end