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

  private

  def comment_params
    params.require(:comment).permit(:body, :output_id)
  end
end
