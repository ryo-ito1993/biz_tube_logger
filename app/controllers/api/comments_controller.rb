class Api::CommentsController < ApplicationController

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      output = Output.find(comment.output_id)
      render json: output.to_json(include: [:user, { comments: { include: :user } }])
    else
      render json: comment.errors, status: :bad_request
    end
  end

  def update
    comment = current_user.comments.find(params[:id])
    if comment.update(comment_params)
      output = Output.find(comment.output_id)
      render json: output.to_json(include: [:user, { comments: { include: :user } }])
    else
      render json: comment.errors, status: :bad_request
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    output_id = comment.output_id
    comment.destroy!
    output = Output.find(output_id)
    render json: output.to_json(include: [:user, { comments: { include: :user } }])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :output_id)
  end
end
