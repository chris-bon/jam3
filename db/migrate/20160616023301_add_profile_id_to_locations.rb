class AddProfileIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :profile_id, :integer
  end
end
