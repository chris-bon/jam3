class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content_md
      t.text :content_html
      t.boolean :draft
      t.integer :user_id
      t.string :slug
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
