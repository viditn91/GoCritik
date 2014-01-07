class ResourcesController < ApplicationController
  before_action :set_resource, only: :show
  before_action :get_fields, only: [:show, :index]

  def index
    @resources = Resource.all
  end

  def show
  end

private
  def set_resource
    ## fixed
    ## Please use find_by or where
    @resource = Resource.find_by(permalink: params[:id])
    ## fixed
    ## Same as described in comments_controller
    unless @resource
      flash[:alert] = "#{ ResourceName.capitalize } not found"
      redirect_to_back_or_default_path
    end
  end

  def get_fields
    @location_field = Field.find_by(name: 'Location')
    @city_field = Field.find_by(name: 'City')
  end

end