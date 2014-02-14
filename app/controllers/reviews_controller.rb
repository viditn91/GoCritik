class ReviewsController < ApplicationController
  load_and_authorize_resource 
  skip_load_resource only: [:create] 
  # before_action :authorize_user, only: :create
  before_action :set_resource, only: :index
  # before_action :set_review, only: [:show, :destroy]
  respond_to :html, :json

  def create
    @review = current_user.reviews.build(review_params)
    respond_with @review do |format|
      format.html do
        if @review.save
          flash[:notice] = "Review created successfully"
          redirect_to_back_or_default_path
        else
          ## fixed
          ## Please show an error message when review not saved successfully
          flash[:error] = @review.errors
          redirect_to_back_or_default_path
        end
      end
      format.json do 
        render :json => @review if @review.save
      end
    end
  end

  def index
    @reviews = Review.where(resource_id: @resource.id)
    respond_with @reviews
  end

  def show
    @resource_keywords_template = Template.find_by(controller: 'reviews', action: 'show', view_element: 'resource keywords')
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
  # def set_review
  #   @review = Review.find_by(id: params[:id])
  #   ## fixed
  #   ## Same as described in comments_controller
  #   unless @review
  #     redirect_to_back_or_default_path
  #   end
  # end

  def set_resource
    @resource = Resource.find_by(permalink: params[:permalink])
  end

  def review_params
    params.require(:review).permit(:content, :resource_id)
  end

end