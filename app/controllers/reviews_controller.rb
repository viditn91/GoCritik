class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @review = Review.new review_params
    @review.user_id = current_user.id
    if @review.save
      redirect_to :back, notice: "Review created successfully"
    else
      redirect_to :back
    end
  end

private
  # def set_review
  #   review = Review.find_by(id: params[:id])
  #   review ? @review = review : redirect_to(resources_path, notice: "Record not found") 
  # end

  def review_params
    params.require(:review).permit(:content, :resource_id)
  end

end