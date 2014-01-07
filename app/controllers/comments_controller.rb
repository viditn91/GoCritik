class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_comment, only: :destroy

  def create
    @comment = Comment.new comment_params
    @comment.user_id = current_user.id
    respond_to do |format|
      format.js do
        unless @comment.save
          flash.now[:error] = "Comment could not be created, some error occured"
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        unless @comment.destroy
          flash.now[:error] = "Comment could not be removed, some error occured"
        end
      end
    end
  end

private
  def set_comment
    @comment = Comment.find_by(id: params[:id])
    ## fixed
    ## unless @comment = comment
    ##  redirect_to(resources_path, notice: "Record not found")
    ## end
    unless @comment
      flash.now[:error] = "Comment Not Found"
      render action: params[:action]
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :review_id)
  end

end