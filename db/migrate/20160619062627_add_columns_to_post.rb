class AddColumnsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :body, :text
    add_column :posts, :featured, :boolean
    add_column :posts, :author_id, :integer
    add_column :posts, :category_id, :integer
    add_column :posts, :average_rating, :float
    add_column :posts, :published_at, :time
    add_column :posts, :expired_at, :time
  end
end