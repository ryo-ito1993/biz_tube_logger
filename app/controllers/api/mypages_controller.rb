class Api::MypagesController < ApplicationController
  before_action :authenticate!
  def index
    @videos = Video.joins(:outputs).where(outputs: { user_id: current_user.id }).distinct.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    @likes = Like.joins(:output).where(outputs: { user_id: current_user.id }).count
    @comments = Comment.joins(:output).where(outputs: { user_id: current_user.id }).count
    render :index, formats: :json, handlers: 'jbuilder'
  end
end
