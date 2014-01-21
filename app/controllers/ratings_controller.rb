class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :set_resource, only: [:create, :update]
  before_action :set_rating, only: :update

  def create
    @rating = @resource.ratings.build
    @rating.user_id = current_user.id
    @rating.value = rating_params[:value].to_f
    respond_to do |format|
      ## fixed
      ## Also, note that conditions should be inside the format.js, format.html etc blocks.
      ## Wouldn't this work here?
      ## format.js do
      ##  @resource if @rating.save
      ## end
      format.js do
        unless @rating.save
          flash.now[:error] = "Rating could not be saved, some error occured"
        end
      end
    end
  end

  def update
    respond_to do |format|
      ## fixed
      ## Same as above
      format.js do
        unless @rating.update(value: rating_params[:value].to_f)
          flash.now[:error] = "Rating could not be updated, some error occured"
        end
      end
    end
  end

private
  def set_resource
    @resource = Resource.find_by(permalink: rating_params[:permalink])
    unless @resource
      flash[:error] = "#{ ResourceName.capitalize.singularize } not found"
      redirect_to_back_or_default_path
    end
  end

  def set_rating
    ## fixed
    ## Please use find_by or where
    @rating = @resource.ratings.find_by(user_id: current_user.id)
    unless @rating
      flash.now[:error] = "Rating Not found"
      render action: params[:action]
    end
  end

  def rating_params
    params.require(:rating).permit(:permalink, :value)
  end

end