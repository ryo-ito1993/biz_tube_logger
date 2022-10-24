class Video < ApplicationRecord
  belongs_to :user
  has_many :outputs, dependent: :destroy
  has_many :video_categories, dependent: :destroy
  has_many :categories, through: :video_categories
  has_many :bookmarks, dependent: :destroy
  validates :youtube_id, :title, :view_count, :published_at, :thumbnail, presence: true

  def create_videodata_from_youtube(youtube_id)
    SetYtService.new
    yt_video = Yt::Video.new id: youtube_id
    self.youtube_id = youtube_id
    self.title = yt_video.title
    self.view_count = yt_video.view_count
    self.published_at = yt_video.published_at
    self.thumbnail = yt_video.thumbnail_url(size = :high)
  end

  def categories_create(categories_name)
    categories_id = []
    categories_name.each do |name|
      category = Category.find_by(name:)
      categories_id << category.id
    end
    self.category_ids = categories_id
  end
end
