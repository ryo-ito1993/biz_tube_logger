class Api::OutputsController < ApplicationController
  before_action :set_output, only: %i[update destroy]
  before_action :authenticate!, only: %i[create update destroy]

  def show
    @outputs = Output.where(video_id: params[:id]).includes(:user, :likes, :comments).order(created_at: :asc)
    render json: @outputs.to_json(include: [:user, :likes, { comments: { include: :user } }])
  end

  def create
    @output = current_user.outputs.build(output_params)
    if @output.save
      render json: @output.to_json(include: :user)
    else
      render json: @output.errors, status: :bad_request
    end
  end

  def update
    if @output.update(output_params)
      render json: @output.to_json(include: :user)
    else
      render json: @output.errors, status: :bad_request
    end
  end

  def destroy
    @video = Video.find(@output.video_id)
    # output投稿が1件のみの場合、videoも同時に削除
    if @video.outputs.length == 1
      @video.destroy!
      render json: [@video, @output]
    else
      @output.destroy!
      render json: @output
    end
  end

  private

  def set_output
    @output = current_user.outputs.find(params[:id])
  end

  def output_params
    params.require(:output).permit(:id, :summary, :impression, :video_id)
  end
end
