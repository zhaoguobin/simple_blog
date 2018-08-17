class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  validates :name, presence: true, uniqueness: true
end
