class Admin::FieldsController < Admin::BaseController
  before_action :set_field, only: [:edit, :update, :destroy]
  #as PATCH request is sent, if the field_type is changed, the options hash is to be emptied explicitly
  # before_action :remove_options_if_params_empty, only: [:update]

  def new
    @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    respond_to do |format|
      if @field.save
        format.html { redirect_to admin_fields_path, notice: 'Field was successfully created.' }
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def index
    @fields = Field.all
  end

  def update
    respond_to do |format|
      if @field.update(field_params)
        format.html { redirect_to admin_fields_path, notice: 'Field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @field.destroy
      respond_to do |format|
        format.html { redirect_to admin_fields_path, :notice => 'Field successfully removed' }
        format.json { head :no_content }
      end
    end
  end

private

  def set_field
    @field = Field.find_by(id: params[:id]) if Field.exists?(params[:id])
  end

  def field_params
    #[FIXME] using permit! will allow user to update any attribute.
    #[DOUBT] But the user can update any attribute, provided that all records are empty under that attribute
    params.require(:field).permit!
  end

  def remove_options_if_params_empty
    @field.options = nil if field_params["options"].blank?
  end

end
