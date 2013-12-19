class Admin::BaseController < ApplicationController
  
  before_action :require_admin_user

  def home
  end
  
protected
  
  def require_admin_user
    redirect_to(root_path, notice: "Unauthorized Access") unless current_user.try(:admin?)
  end

end