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

  searchable do
    string  :title
    text    :body 
    # text    :comments do
    #   comments.map { |comment| comment.body }
    # end
    boolean :featured
    integer :blog_id
    integer :author_id
    integer :category_ids, :multiple => true
    float   :average_rating
    time    :published_at
    time    :expired_at
    string  :sort_title do
      title.downcase.gsub /^(an?|the)/, ''
    end
  end
end
