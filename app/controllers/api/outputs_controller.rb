class Api::OutputsController < ApplicationController

  def show
    @outputs = Output.where(video_id: params[:id])
    render json: @outputs.to_json(include: :user)
  end

  def update
    @output = current_user.outputs.find(params[:id])
    if @output.update(output_params)
      render json: @output.to_json(include: :user)
    else
      render json: @output.errors, status: :bad_request
    end
  end

  private

  def output_params
    params.require(:output).permit(:summary, :impression)
  end


end