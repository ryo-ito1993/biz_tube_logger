class Api::VideopreviewController < ApplicationController
  GOOGLE_API_KEY = ENV.fetch('GOOGLE_API_KEY', nil)

  def set_yt
    Yt.configure do |config|
      config.api_key = GOOGLE_API_KEY
      config.log_level = :debug
    end
  end

  def create
    youtube_id = if params[:youtube_url][0..16] == 'https://youtu.be/'
                   params[:youtube_url][17..27]
                 else
                   params[:youtube_url][32..42]
                 end

    set_yt
    yt_video = Yt::Video.new id: youtube_id
    video = Video.new
    if video.title = yt_video.title
      render json: youtube_id
    else
      render json: yt_video.errors, status: :bad_request
    end
  end
end
