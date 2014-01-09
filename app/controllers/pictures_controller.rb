class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :update]

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      flash[:notice] = 'Picture successfully uploaded'
    else
      flash[:error] = 'An error occured, picture cannot be uploaded'
    end
    redirect_to @picture.imageable 
  end

  def show
  end

  def update
    if @picture.update(picture_params)
      flash[:notice] = 'Picture successfully updated'
    else
      flash[:error] = 'An error occured, picture cannot be updated'
    end
    redirect_to @picture.imageable
  end

private
  def set_picture
    @picture = Picture.find_by(imageable_type: picture_params[:imageable_type], imageable_id: picture_params[:imageable_id])
    unless @picture
      flash[:error] = "Picture not found"
    end
  end

  def picture_params
    params.require(:picture).permit(:photo, :imageable_type, :imageable_id)
  end
end