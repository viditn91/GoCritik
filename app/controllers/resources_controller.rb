class ResourcesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_resource, only: :show
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
    if params[:search].in? [ nil, '' ]
      @resources = Resource.search params[:search], :include => :fields_values,
        :select => '(rating/ratings_count) as rating_value',
        :order  => 'rating_value DESC'
    else
      @resources = Resource.search params[:search], :include => :fields_values
    end
    @keywords_template = Template.find_by(controller: 'resources', action: 'index', view_element: 'keywords')
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

end