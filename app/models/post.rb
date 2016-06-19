class Post < ActiveRecord::Base
 extend FriendlyId
  friendly_id :title, use: :slugged

  before_save { MarkdownWriter.update_html self }

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :content_md, presence: true

  paginates_per 30

  belongs_to :user

  # Scopes
  scope :published, -> { where(draft: false).order 'updated_at DESC' }
  scope :drafted,   -> { where(draft:  true).order 'updated_at DESC' }
end
