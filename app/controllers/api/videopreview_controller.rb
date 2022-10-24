class Api::VideopreviewController < ApplicationController
  before_action :authenticate!

  def create
    SetYtService.new
    yt_video = Yt::Video.new id: params[:youtube_id]
    video = Video.new
    if (video.title = yt_video.title)
      render json: params[:youtube_id]
    else
      render json: yt_video.errors, status: :bad_request
    end
  end
end
