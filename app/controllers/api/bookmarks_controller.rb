class Api::BookmarksController < ApplicationController
  before_action :set_video, only: %i[create destroy]

  def index
    @bookmarks = current_user.bookmark_videos.includes(:user, :categories, { outputs: [:user, :comments] })
    @video_comments = Output.joins(:comments).group("outputs.video_id").count
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def create
    current_user.bookmark(@video)
    render json: @video
  end

  def destroy
    current_user.unbookmark(@video)
    render json: @video
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end