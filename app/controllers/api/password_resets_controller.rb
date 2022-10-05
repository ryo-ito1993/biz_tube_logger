class Api::PasswordResetsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    @user&.deliver_reset_password_instructions!
    render nothing: true
  end

  def edit
    user = User.load_from_reset_password_token(params[:id])
    render json: user
  end

  def update
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:password_reset][:password_confirmation]
    if @user.change_password(params[:password_reset][:password])
      render nothing: true
    else
      render json: @user.errors, status: :bad_request
    end
  end
end
