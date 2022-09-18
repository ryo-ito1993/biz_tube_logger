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

  def destroy
    comment = Comment.find(params[:id])
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
