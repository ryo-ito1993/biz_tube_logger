class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[me]

  def create
    user = User.new(user_params)

    if user.save
      token = user.create_tokens
      render json: { token: token }
    else
      render json: user.errors, status: :bad_request
    end
  end

  def show
    @videos = Video.joins(:outputs).where(outputs: {user_id: params[:id]}).distinct.includes(:user, :outputs, :categories).order('outputs.created_at DESC')
    @video_comments = Output.joins(:comments).group('outputs.video_id').count
    @video_likes = Output.joins(:likes).group('outputs.video_id').count
    render :index, formats: :json, handlers: 'jbuilder'
  end

  def me
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
