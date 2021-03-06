class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :tag_group, counter_cache: true, touch: true
  has_and_belongs_to_many :articles
  
  validates :name, presence: true, uniqueness: true

  def self.hot(limit = 10)
    order(articles_count: :desc).limit(limit)
  end

  def published_articles
    articles.where.not(published_at: nil).order(published_at: :desc)
  end

end
