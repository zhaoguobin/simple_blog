class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  has_many :articles, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def published_articles
    articles.where.not(published_at: nil).order(published_at: :desc)
  end
end
