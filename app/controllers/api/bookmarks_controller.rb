class Api::BookmarksController < ApplicationController
  before_action :set_video, only: %i[create destroy]

  def index
    @bookmarks = current_user.bookmark_videos
    render json: @bookmarks
  end

  def create
    current_user.bookmark(@video)
    render json: @video
  end

  def destroy
    current_user.unbookmark(@video)
    render json: @video
  end

  def bookmark_list
    @bookmarks = current_user.bookmark_videos.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    render :bookmark_list, formats: :json, handlers: 'jbuilder'
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
