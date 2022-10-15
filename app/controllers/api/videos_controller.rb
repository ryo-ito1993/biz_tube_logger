class Api::VideosController < ApplicationController
  before_action :authenticate!, only: %i[create]
  include Pagy::Backend

  def index
    @videos = Video.includes(:user, :categories, outputs: [:comments, :likes]).order('outputs.created_at DESC')
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def display_videos
    pagy_a, @videos = pagy_array(Video.includes(:user, :categories, outputs: [:comments, :likes]).order('outputs.created_at DESC'))
    pagy_headers_merge(pagy_a)
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    # 同じvideoレコードがある場合、既存のvideoにoutputを紐付ける
    if (@video = Video.find_by(youtube_id: params[:youtube_id]))
      @output = current_user.outputs.build(output_params)
      @output.video_id = @video.id
      if @output.save
        render json: [@video, @output], status: :ok
      else
        render json: @output.errors, status: :bad_request
      end
    # レコードがない場合は新たにvideoを作成し、outputに紐づける
    else
      @video = current_user.videos.build
      @video.create_videodata_from_youtube(params[:youtube_id])
      @video.categories_create(params[:selected_categories])
      ApplicationRecord.transaction do
        @video.save!
        @output = current_user.outputs.build(output_params)
        @output.video_id = @video.id
        @output.save!
        render json: [@video, @output], status: :ok
      end
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
