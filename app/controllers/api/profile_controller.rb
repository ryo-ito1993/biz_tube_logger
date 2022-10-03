class Api::ProfileController < ApplicationController
  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:profile).permit(:name, :email)
  end
end
