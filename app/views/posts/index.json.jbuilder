json.array! @posts do |post|
  json.extract! post, :id, :title, :content_md, :content_html, :draft, :user_id, :slug, :created_at, :updated_at
  json.url post_url(post, format: :json)
end
