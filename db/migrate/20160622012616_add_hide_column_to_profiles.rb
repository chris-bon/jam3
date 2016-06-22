class AddHideColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :hide, :boolean
  end
end
