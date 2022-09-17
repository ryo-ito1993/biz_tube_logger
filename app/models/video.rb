class Video < ApplicationRecord
  belongs_to :user
  has_many :outputs, dependent: :destroy
  has_many :video_categories, dependent: :destroy
  has_many :categories, through: :video_categories
  validates :youtube_id, presence: true
end
