class Api::VideosController < ApplicationController

  def index
    @videos = Video.includes(:user, :outputs)
    render :index, formats: :json, handlers: 'jbuilder'
  end
end