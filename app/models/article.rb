class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :category, counter_cache: true
  
  validates :title, presence: true, uniqueness: true

  def published?
    published_at.present?
  end

  def publish
    update_attribute(:published_at, Time.now) unless published?
  end

  def unpublish
    update_attribute(:published_at, nil) if published?
  end
end
