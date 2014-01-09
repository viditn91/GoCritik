class ResourcesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_resource, only: :show
  before_action :get_fields, only: [:show, :index]
  before_action :load_all_fields, only: [:new, :create]

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.approved = false
    if @resource.save
      flash[:notice] = "Your request for a new #{ ResourceName } is submitted"
      redirect_to resources_path
    else
      render action: 'new'
    end
  end

  def index
    @resources = Resource.approved
  end

  def show
  end

private
  def set_resource
    ## fixed
    ## Please use find_by or where
    @resource = Resource.approved.find_by(permalink: params[:id])
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

  def resource_params
    params.require(:resource).permit(:name, :description, fields_values_attributes: [:value, :field_id])
  end

  def load_all_fields
    @fields = Field.all
  end

end