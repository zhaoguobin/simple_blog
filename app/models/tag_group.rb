class TagGroup < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :tags, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
