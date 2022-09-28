class Api::VideosController < ApplicationController
  def index
    @videos = Video.includes(:user, :categories).order(created_at: :desc)
    @video_comments = Output.joins(:comments).group('outputs.video_id').count
    @video_likes = Output.joins(:likes).group('outputs.video_id').count
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    @video = current_user.videos.build
    @video.create_videodata_from_youtube(params[:youtube_url])
    @video.categories_create(params[:selected_categories])

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

  def output_params
    params.require(:output).permit(:summary, :impression)
  end
end
