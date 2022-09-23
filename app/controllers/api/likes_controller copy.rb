class Api::OutputsController < ApplicationController
  before_action :set_output, only: %i[create destroy]

  def index
    @likes = current_user.like_outputs
    render json: @likes
  end

  def create
    current_user.like(@output)
    render json: @output
  end

  def destroy
    current_user.unlike(@output)
    render json: @output
  end


  private

  def set_output
    @output = Output.find(params[:id])
  end
end
