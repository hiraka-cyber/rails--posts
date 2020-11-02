class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user, presence: true
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :img, ImageUploader
end
