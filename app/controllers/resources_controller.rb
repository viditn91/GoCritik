class ResourcesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_resource, only: :show
  before_action :load_all_fields, only: [:new, :create, :index]

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
    @resources = Resource.search params[:search], :include => :fields_values
    @keywords_template = Template.find_by(controller: 'resources', action: 'index', view_element: 'keywords')
    request.query_parameters.each do |a, b|
      unless a == "search" || a == "utf8"
        @resources = filter_results(a.to_i, b)
      end
    end
  end

  def show
    @keywords_template = Template.find_by(controller: 'resources', action: 'show', view_element: 'keywords')
    @tags_template = Template.find_by(controller: 'resources', action: 'show', view_element: 'tags')
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

  def resource_params
    params.require(:resource).permit(:name, :description, fields_values_attributes: [:value, :field_id])
  end

  def load_all_fields
    @fields = Field.all
  end

  def filter_results(a, b)
    @resources.select do |resource|
      resource if(resource.fields_values.map(&:field_id).include?(a) &&
        resource.fields_values.find_by(field_id: a).value.to_s == b)
    end
  end
end