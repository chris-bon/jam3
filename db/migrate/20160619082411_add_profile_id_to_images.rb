class AddProfileIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :profile_id, :integer
  end
end
