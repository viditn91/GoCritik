class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :update]

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to @picture.imageable, notice: 'Picture successfully uploaded'
    else
      redirect_to @picture.imageable, notice: 'An error occured'
    end
  end

  def show
  end

  def update
    if @picture.update(picture_params)
      redirect_to @picture.imageable
    end
  end

private
  def set_picture
    @picture = Picture.find_by(imageable_type: picture_params[:imageable_type], imageable_id: picture_params[:imageable_id])
  end

  def picture_params
    params.require(:picture).permit(:photo, :imageable_type, :imageable_id)
  end
end