class Video < ApplicationRecord
  belongs_to :user
  has_many :outputs, dependent: :destroy
  validates :youtube_id, presence: true
end
