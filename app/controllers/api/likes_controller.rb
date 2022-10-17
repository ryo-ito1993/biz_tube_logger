class Api::LikesController < ApplicationController
  before_action :set_output, only: %i[create destroy]
  before_action :authenticate!

  def create
    current_user.like(@output)
    render json: @output.to_json(include: [:user, :likes, { comments: { include: :user } }])
  end

  def destroy
    current_user.unlike(@output)
    render json: @output.to_json(include: [:user, :likes, { comments: { include: :user } }])
  end

  private

  def set_output
    @output = Output.find(params[:id])
  end
end
