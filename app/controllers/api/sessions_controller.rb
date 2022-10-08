class Api::SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      token = user.create_tokens

      render json: { token: }
    else
      head :unauthorized
    end
  end

  def guest_login
    user = User.guest

    if user
      token = user.create_tokens

      render json: { token: }
    else
      head :unauthorized
    end
  end
end
