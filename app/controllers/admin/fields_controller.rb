class Admin::FieldsController < Admin::BaseController
  before_action :set_field, only: [:edit, :update, :destroy]
  rescue_from Exceptions::RequiredFieldError, with: :drop_action_on_required_field
  rescue_from ActiveRecord::SubclassNotFound, with: :prevent_breach

  def new
    @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    if @field.save
      flash[:notice] = "Field was successfully created"
      redirect_to admin_fields_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def index
    @fields = Field.all
    @field_columns = Field.column_names
  end

  def update
    @field = Field.find_by(id: params[:id]) if @field.update(field_params)
    if @field.update(field_params)
      flash[:notice] = "Field was successfully updated"
      redirect_to admin_fields_path
    else
      render action: 'edit'
    end
  end

  def destroy
    if @field.destroy
      flash[:notice] = "Field successfully removed"
    else
      flash[:error] = "Field couldn't removed, an error occured"
    end
    redirect_to admin_fields_path
  end

private

  def set_field
    @field = Field.find_by(id: params[:id])
    unless @field
      flash[:error] = "Field Not found"
      redirect_to admin_fields_path
    end
  end

  def field_params
    params.require(:field).permit(:name, :input_type, :type, :default_value, :required, :unique, :searchable, :sortable).tap do |whitelisted|
      whitelisted[:options] = params[:field][:options]
    end
  end

  def drop_action_on_required_field(exception)
    logger.error exception.message
    flash[:error] = exception.message
    redirect_to_back_or_default_path(admin_path)
  end

  def prevent_breach(exception)
    logger.error exception.message
    flash[:error] = "Do not temper with the form, Choose the field type from the select-box"
    redirect_to_back_or_default_path(admin_path)
  end

end