class RemoveLocationFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :location, :string
  end
end
