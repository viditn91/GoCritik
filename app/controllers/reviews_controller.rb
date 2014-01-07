class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_review, only: [:show, :destroy]

  def create
    @review = Review.new review_params
    @review.user_id = current_user.id
    if @review.save
      redirect_to :back, notice: "Review created successfully"
    else
      ## Please show an error message when review not saved successfully
      redirect_to :back
    end
  end

  def show
  end

  def destroy
    if @review.destroy
      redirect_to :back, notice: "Review deleted successfully"
    else
      ## Please show an error message when review not destroyed successfully
      redirect_to :back
    end
  end

private
  def set_review
    review = Review.find_by(id: params[:id])
    ## Same as described in comments_controller
    review ? @review = review : redirect_to(resources_path, notice: "Record not found")
  end

  def review_params
    params.require(:review).permit(:content, :resource_id)
  end

end