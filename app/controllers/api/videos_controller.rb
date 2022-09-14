class Api::VideosController < ApplicationController
  GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']

  def set_yt
    Yt.configure do |config|
      config.api_key = GOOGLE_API_KEY
      config.log_level = :debug
    end
  end

  def index
    @videos = Video.includes(:user, :outputs)
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    youtube_url = video_params[:youtube_url]
    if youtube_url[0..16] == "https://youtu.be/"
      youtube_id = youtube_url[17..27]
    else
      youtube_id = youtube_url[32..42]
    end

    set_yt
    yt_video = Yt::Video.new id: youtube_id
    @video = current_user.videos.build
    @video.youtube_id = video_params[:youtube_url]
    @video.title = yt_video.title
    @video.view_count = yt_video.view_count
    @video.published_at = yt_video.published_at
    @video.thumbnail = yt_video.thumbnail_url(size = :high)
    if @video.save
      @output = current_user.outputs.build(output_params)
      @output.video_id = @video.id
    else
      render json: @video.errors, status: :bad_request
    end

    if @output.save
      render json: [@video,@output], status: :ok
    else
      render json: @video.errors, status: :bad_request
    end
  end

  private

  def video_params
    params.permit(:youtube_url)
  end

  def output_params
    params.require(:output).permit(:summary, :impression)
  end


end