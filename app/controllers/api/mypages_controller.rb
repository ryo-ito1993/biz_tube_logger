class Api::MypagesController < ApplicationController
  before_action :authenticate!
  def index
    @videos = Video.joins(:outputs).where(outputs: { user_id: current_user.id }).distinct.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def likes_comments_count
    @likes = Like.joins(:output).where(outputs: { user_id: current_user.id }).count
    @comments = Comment.joins(:output).where(outputs: { user_id: current_user.id }).count
    render :likes_comments_count, formats: :json, handlers: 'jbuilder'
  end
end
