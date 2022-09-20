class Video < ApplicationRecord
  belongs_to :user
  has_many :outputs, dependent: :destroy
  has_many :video_categories, dependent: :destroy
  has_many :categories, through: :video_categories
  validates :youtube_id, presence: true

  GOOGLE_API_KEY = ENV.fetch('GOOGLE_API_KEY', nil)

  def set_yt
    Yt.configure do |config|
      config.api_key = GOOGLE_API_KEY
      config.log_level = :debug
    end
  end

  def create_videodata_from_youtube(youtube_url)
    youtube_id =  if youtube_url[0..16] == 'https://youtu.be/'
      youtube_url[17..27]
    else
      youtube_url[32..42]
    end
    set_yt
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
