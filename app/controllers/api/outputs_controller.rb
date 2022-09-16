class Api::OutputsController < ApplicationController

  def show
    @outputs = Output.where(video_id: params[:id])
    render json: @outputs.to_json(include: :user)
  end


end