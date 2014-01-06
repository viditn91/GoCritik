class Admin::FieldsController < Admin::BaseController
  before_action :set_field, only: [:edit, :update, :destroy]
  #as PATCH request is sent, if the type is changed, the options hash is to be emptied explicitly
  # before_action :remove_options_if_params_empty, only: [:update]
  rescue_from Exceptions::RequiredFieldError, with: :drop_action_on_required_field

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
    @field = @field.becomes(TextField)
    respond_to do |format|
      if @field.save(field_params)
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
    field = Field.find_by(id: params[:id])
    field ? @field = field : redirect_to(admin_fields_path, notice: "Record not found")
  end

  def field_params
    params.require(:field).permit(:name, :input_type, :type, :default_value, :required, :unique).tap do |whitelisted|
      whitelisted[:options] = params[:field][:options]
    end
  end

  # def remove_options_if_params_empty
  #   @field.options = nil if field_params["options"].blank?
  # end

  def drop_action_on_required_field(exception)
    logger.error exception.message
    flash[:notice] = exception.message
    redirect_to :back
  end

end