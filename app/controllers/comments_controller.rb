class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: :destroy

  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js
      end
    end
  end

private
  def set_comment
    comment = Comment.find_by(id: params[:id])
    comment ? @comment = comment : redirect_to(resources_path, notice: "Record not found") 
  end

  def comment_params
    params.require(:comment).permit(:content, :review_id)
  end

end