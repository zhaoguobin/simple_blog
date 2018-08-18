class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  has_many :articles, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
