class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :tag_group, counter_cache: true
  has_and_belongs_to_many :articles
  
  validates :name, presence: true, uniqueness: true

  def published_articles
    articles.where.not(published_at: nil).order(published_at: :desc)
  end
end
