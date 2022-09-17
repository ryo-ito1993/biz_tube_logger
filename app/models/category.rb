class Category < ApplicationRecord
  has_many :video_categories, dependent: :destroy
  has_many :videos, through: :video_categories
  validates :name, presence: true, uniqueness: true
end
