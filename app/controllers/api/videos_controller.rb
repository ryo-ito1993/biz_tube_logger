class Api::VideosController < ApplicationController
  GOOGLE_API_KEY = ENV.fetch('GOOGLE_API_KEY', nil)

  def set_yt
    Yt.configure do |config|
      config.api_key = GOOGLE_API_KEY
      config.log_level = :debug
    end
  end

  def index
    @videos = Video.includes(:user, :categories, { outputs: [:user, :comments] }).order(created_at: :desc)
    @video_comments = Output.joins(:comments).group("outputs.video_id").count
    render :index, formats: :json, handlers: 'jbuilder'
  end

  # @videos = Output.joins(:comments).group("outputs.video_id").count

  def create
    youtube_url = video_params[:youtube_url]
    youtube_id =  if youtube_url[0..16] == 'https://youtu.be/'
                    youtube_url[17..27]
                  else
                    youtube_url[32..42]
                  end

    set_yt
    yt_video = Yt::Video.new id: youtube_id
    @video = current_user.videos.build
    @video.youtube_id = youtube_id
    @video.title = yt_video.title
    @video.view_count = yt_video.view_count
    @video.published_at = yt_video.published_at
    @video.thumbnail = yt_video.thumbnail_url(size = :high)

    categories_name = category_params[:selected_categories]
    categories_id = []
    categories_name.each do |name|
      category = Category.find_by(name:)
      categories_id << category.id
    end
    @video.category_ids = categories_id

    if @video.save
      @output = current_user.outputs.build(output_params)
      @output.video_id = @video.id
    else
      render json: @video.errors, status: :bad_request
    end

    if @output.save
      render json: [@video, @output], status: :ok
    else
      render json: @video.errors, status: :bad_request
    end
  end

  def show
    @video = Video.where(id: params[:id])
    render json: @video.to_json(include: { categories: { only: :name } })
  end

  private

  def video_params
    params.permit(:youtube_url)
  end

  def category_params
    params.permit(selected_categories: [])
  end

  def output_params
    params.require(:output).permit(:summary, :impression)
  end
end
