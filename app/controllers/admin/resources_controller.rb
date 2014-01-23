class Admin::ResourcesController < Admin::BaseController
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :approve]
  before_action :set_column_names, only: [:show, :index]
  before_action :load_all_fields, only: [:new, :create, :edit, :index, :update]
  after_action :expire_action_cache, only: [:create, :update, :destroy]
  # liquid template requirement
  liquid_methods :fields_values

  caches_action :index, :cache_path => Proc.new { |c| c.params }

  ##fixed
  ## Please don't use scaffolding when generating controllers. Please remove the json format blocks
  ## Also update the admin controllers like we did the user facing controllers.
  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(new_resource_params)
    @resource.state = true
    @resource.suggested_by = current_user.id
    if @resource.save
      flash[:notice] = "#{ ResourceName } was successfully created"
      redirect_to admin_resources_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def show
  end

  def index
    params[:status] ||= :approved
    session[:status] = params[:status]
    @resources = Resource.send(params[:status]).includes(:fields_values)
  end

  def update
    if @resource.update(edit_resource_params)
      flash[:notice] = "#{ ResourceName } was successfully updated"
      redirect_to path_for_admin_resources_path
    else
      render action: 'edit'
    end
  end

  def destroy
    if @resource.destroy
      flash[:notice] = "#{ ResourceName } successfully removed"
    else
      flash[:error] = "#{ ResourceName } couldn't removed, an error occured"
    end
    redirect_to path_for_admin_resources_path
  end

  def approve
    if @resource.approve
      flash[:notice] = "#{ ResourceName } approved successfully, its now listed under Approved #{  ResourceName.pluralize }"
      redirect_to path_for_admin_resources_path
    else
      flash[:error] = "#{ ResourceName } couldn't be approved, Something went bad"
      redirect_to path_for_admin_resources_path
    end
  end

private
  def set_resource
    @resource = Resource.find_by(permalink: params[:id])
    unless @resource
      flash[:alert] = "#{ ResourceName.capitalize } not found"
      redirect_to admin_resources_path
    end
  end

  def new_resource_params
    params.require(:resource).permit(:name, :description, fields_values_attributes: [:value, :field_id])
  end

  def edit_resource_params
    params.require(:resource).permit(:name, :description, fields_values_attributes: [:value, :field_id, :id])
  end

  def set_column_names
    @resource_columns = Resource.column_names - ['id', 'created_at', 'updated_at', 'permalink', 'state', 'suggested_by', 'ratings_count', 'reviews_count', 'rating', 'delta']
  end

  def load_all_fields
    @fields = Field.all
  end

  def expire_action_cache
    if @resource.state
      expire_action :action => :index
      expire_action :action => :index, :status => :approved
    else
      expire_action :action => :index, :status => :pending
    end

  end

end