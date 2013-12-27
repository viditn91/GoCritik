class ReviewsController < ApplicationController

  def create
    @review = Review.new review_params
    if @review.save
      redirect_to :back, notice: "Review created successfully"
    else
      redirect_to :back
    end
  end

private
  def review_params
    params.require(:review).permit(:content, :resource_id)
  end
end