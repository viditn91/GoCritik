class ResourcesController < ApplicationController
  before_action :set_resource, only: :show

  def index
    @resources = Resource.all
    @location_field = Field.find_by_name(:Location)
    @city_field = Field.find_by_name(:City)
  end

  def show
  end

private
  def set_resource
    ## Please use find_by or where
    resource_record = Resource.find_by_permalink(params[:id])
    ## Same as described in comments_controller
    resource_record ? @resource = resource_record : redirect_to(resources_path, notice: "Record not found")
  end

end