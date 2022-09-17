class VideoCategory < ApplicationRecord
  belongs_to :video
  belongs_to :category
  validates :video_id, uniqueness: { scope: :category_id }
end
