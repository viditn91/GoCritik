class Admin::ResourcesController < Admin::BaseController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(new_resource_params)
    respond_to do |format|
      if @resource.save
        format.html { redirect_to admin_resources_path, notice: 'Resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def index
    @resources = Resource.includes(:fields_values)
    @fields = Field
  end

  def update
    respond_to do |format|
      if @resource.update(edit_resource_params)
        format.html { redirect_to admin_resources_path, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_resources_url }
      format.json { head :no_content }
    end
  end


private
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def new_resource_params
    params.require(:resource).permit(fields_values_attributes: [:value, :field_id])
  end
  
  def edit_resource_params
    params.require(:resource).permit(fields_values_attributes: [:value, :field_id, :id])
  end
end