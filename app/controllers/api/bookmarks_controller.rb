class Api::BookmarksController < ApplicationController
  before_action :set_video, only: %i[create destroy]

  def index
    bookmarks = current_user.bookmark_videos
    render json: bookmarks, include: [:user, :categories, { outputs: [:user, :comments] }]
  end

  def create
    bookmark = current_user.bookmark(@video)
    render json: @video, include: [:user, :categories, { outputs: [:user, :comments] }]
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