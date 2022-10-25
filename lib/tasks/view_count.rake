namespace :view_count do
  desc 'Videoの再生回数を更新する'
  task update_view_count: :environment do
    @video = Video.all
    @video.each do |video|
      SetYtService.new
      yt_video = Yt::Video.new id: video.youtube_id
      video.view_count = yt_video.view_count
      video.save!
    end
  end
end
