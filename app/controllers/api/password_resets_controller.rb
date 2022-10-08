class Api::PasswordResetsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    @user&.generate_reset_password_token!
    UserMailer.reset_password_email(@user).deliver_now if @user
  end

  def update
    user = User.load_from_reset_password_token(params[:id])
    raise ActiveRecord::RecordNotFound unless user

    user.password_confirmation = user_params[:password_confirmation]

    if user.change_password(user_params[:password])
      head :ok
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
