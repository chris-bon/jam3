class RemoveEmailFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :email, :string
  end
end
