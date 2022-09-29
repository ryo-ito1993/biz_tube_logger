class Api::MypagesController < ApplicationController
  def show
    @videos = Video.joins(:outputs).where(outputs: {user_id: params[:id]}).distinct.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    @video_comments = Output.joins(:comments).group('outputs.video_id').count
    @video_likes = Output.joins(:likes).group('outputs.video_id').count
    render :show, formats: :json, handlers: 'jbuilder'
  end

  def likes_comments_count
    @likes = Like.joins(:output).where(outputs: {user_id: params[:id]}).count
    @comments = Comment.joins(:output).where(outputs: {user_id: params[:id]}).count
    render :likes_comments_count, formats: :json, handlers: 'jbuilder'
  end
end
