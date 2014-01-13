class Admin::TemplatesController < Admin::BaseController
  before_action :set_template, only: [:edit, :update, :show]
  before_action :set_column_names, only: [:show, :index]

  def edit
  end

  def update
    if @template.update(template_params)
      flash[:notice] = "Template was successfully updated"
      redirect_to admin_templates_path
    else
      render action: 'edit'
    end
  end

  def index
    @templates = Template.all
  end

  def show
  end

private
  def set_template
    @template = Template.find_by(id: params[:id])
    unless @template
      flash[:error] = "Template Not found"
      redirect_to admin_templates_path
    end
  end

  def template_params
    params.require(:template).permit(:content)
  end

  def set_column_names
    @template_columns = Template.column_names - ['id', 'created_at', 'updated_at']
  end
end
