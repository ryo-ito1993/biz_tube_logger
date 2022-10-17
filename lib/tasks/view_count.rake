namespace :view_count do
  desc 'Videoの再生回数を更新する'
  task update_view_count: :environment do
    GOOGLE_API_KEY = ENV.fetch('GOOGLE_API_KEY', nil)
    def set_yt
      Yt.configure do |config|
        config.api_key = GOOGLE_API_KEY
        config.log_level = :debug
      end
    end
    @video = Video.all
    @video.each do |video|
      set_yt
      yt_video = Yt::Video.new id: video.youtube_id
      video.view_count = yt_video.view_count
      video.save!
    end
  end
end
