class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_review, only: [:show, :destroy]

  def create
    @review = Review.new review_params
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "Review created successfully"
      redirect_to_back_or_default_path
    else
      ## fixed
      ## Please show an error message when review not saved successfully
      flash[:error] = "Some error occured, Review couldn't be saved"
      redirect_to_back_or_default_path
    end
  end

  def show
  end

  def destroy
    if @review.destroy
      flash[:notice] = "Review removed successfully"
      redirect_to_back_or_default_path
    else
      ## fixed
      ## Please show an error message when review not destroyed successfully
      flash[:error] = "Some error occured, Review couldn't be saved"
      redirect_to_back_or_default_path
    end
  end

private
  def set_review
    @review = Review.find_by(id: params[:id])
    ## fixed
    ## Same as described in comments_controller
    unless @review
      redirect_to_back_or_default_path 
    end
  end

  def review_params
    params.require(:review).permit(:content, :resource_id)
  end

end