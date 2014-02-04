class LikesController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_like, only: :destroy

  def create
    @like = current_user.likes.build(like_params)
    respond_to do |format|
      ## fixed
      ## Should we write it this way?
      ## format.js { @like.save }
      format.js do
        unless @like.save
          flash.now[:error] = "Like could not be saved"
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        unless @like.destroy
          flash.now[:error] = "Some error occured"
        end
      end
    end
  end

private
  def set_like
    @like = Like.find_by(id: params[:id])
    ## Fixed
    ## Same as described in comments_controller
    unless @like
      flash.now[:error] = "Some error occured"
      render action: params[:action]
    end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end