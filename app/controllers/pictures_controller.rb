class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :update]

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to user_path(@picture.user)
    end
  end

  def show
  end

  def update
    if @picture.update(picture_params)
      redirect_to user_path(@picture.user)
    end
  end

  def destroy
    @picture = Picture.find_by(id: params[:id])
    if @picture.destroy
      redirect_to edit_user_path(@picture.user)
    end
  end

  def code_image 
    @image_data = Picture.find_by(id: params[:id])
    @image = @image_data.binary_data
    send_data(@image, type: @image_data.content_type, filename: @image_data.filename)
  end

private
  def set_picture
    if picture_params[:user_id]
      @picture = Picture.find_by(user_id: picture_params[:user_id])
    elsif picture_params[:resource_id]
      @picture = Picture.find_by(resource_id: picture_params[:resource_id])
    end
  end

  def picture_params
    params.require(:picture).permit(:image_file, :user_id, :resource_id)
  end
end