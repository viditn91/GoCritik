class LikesController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_like, only: :destroy

  def create
    @like = Like.new like_params
    @like.user_id = current_user.id
    respond_to do |format|
      ## Should we write it this way?
      ## format.js { @like.save }
      if @like.save
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @like.destroy
        format.js
      end
    end
  end

private
  def set_like
    like = Like.find_by(id: params[:id])
    ## Same as described in comments_controller
    like ? @like = like : redirect_to(resources_path, notice: "Record not found")
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end