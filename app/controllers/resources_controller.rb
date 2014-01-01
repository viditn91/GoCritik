class ResourcesController < ApplicationController
  before_action :set_resource, only: :show
  
  def index
    @resources = Resource.all
  end

  def show
  end

  # def create_rating
  #   @rating = @resource.ratings.build
  #   respond_to do |format|
  #     if @resource.save
  #       format.js
  #     end
  #   end
  # end

private
  def set_resource
    resource_record = Resource.find_by(id: params[:id])
    resource_record ? @resource = resource_record : redirect_to(resources_path, notice: "Record not found") 
  end

end