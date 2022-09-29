class Api::VideosController < ApplicationController
  def index
    @videos = Video.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    @video_comments = Output.joins(:comments).group('outputs.video_id').count
    @video_likes = Output.joins(:likes).group('outputs.video_id').count
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    youtube_id = if params[:youtube_url][0..16] == 'https://youtu.be/'
      params[:youtube_url][17..27]
    else
      params[:youtube_url][32..42]
    end

    #同じvideoレコードがある場合、既存のvideoにoutputを紐付ける
    if Video.find_by(youtube_id: youtube_id)
      ApplicationRecord.transaction do
        @video = Video.find_by(youtube_id: youtube_id)
        @output = current_user.outputs.build(output_params)
        @output.video_id = @video.id
        @output.save!
      end
    #レコードがない場合は新たにvideoを作成し、outputに紐づける
    else
      @video = current_user.videos.build
      @video.create_videodata_from_youtube(youtube_id)
      @video.categories_create(params[:selected_categories])
      ApplicationRecord.transaction do
        @video.save!
        @output = current_user.outputs.build(output_params)
        @output.video_id = @video.id
        @output.save!
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
