class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :avatar, ItemAvatarUploader

  belongs_to :tag_group, counter_cache: true
  has_and_belongs_to_many :articles
  
  validates :name, presence: true, uniqueness: true
end
