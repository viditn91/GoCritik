class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :require_admin_user
  helper_method :path_for_admin_resources_path

  def home
  end
  
protected
  
  def require_admin_user
    redirect_to(root_path, notice: "Unauthorized Access") unless current_user.try(:admin?)
  end

  def path_for_admin_resources_path
    session[:status] ||= :approved
    admin_resources_path(status: session[:status])
  end

end