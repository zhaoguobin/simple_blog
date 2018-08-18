class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :category, counter_cache: true
  
  validates :title, presence: true, uniqueness: true

  before_save :render_markdown

  def published?
    published_at.present?
  end

  def publish
    update_attribute(:published_at, Time.now) unless published?
  end

  def unpublish
    update_attribute(:published_at, nil) if published?
  end

  protected

  def render_markdown
    body_str = self.body.to_s
    self.body_html = MARKDOWN.render(body_str)
    self.body_toc = TOC.render(body_str)
  end
end
