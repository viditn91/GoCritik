class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :set_rating, only: :update

  def create
    @rating = Rating.new
    @resource = Resource.find_by_permalink(rating_params[:permalink])
    @rating.resource_id = @resource.id
    @rating.user_id = current_user.id
    @rating.value = rating_params[:value]
    respond_to do |format|
      if @rating.save
        format.js { @resource = @resource }
      end
    end
  end

  def update
    @rating.update(value: rating_params[:value])
    respond_to do |format|
      if @rating.save
        format.js { @resource = @resource }
      end
    end
  end
 
private
  def set_rating
    @resource = Resource.find_by_permalink(rating_params[:permalink])
    @rating = @resource.ratings.find_by(user_id: current_user.id)
  end

  def rating_params
    params.require(:rating).permit(:permalink, :value)
  end

end