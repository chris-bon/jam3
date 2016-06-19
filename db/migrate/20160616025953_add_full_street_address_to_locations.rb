class AddFullStreetAddressToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :full_street_address, :string
  end
end
