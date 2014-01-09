class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location

  def store_location
    # store location - this is needed for post-login/logout or post-signup redirect to whatever the user last visited.
    ## fixed
    ## Instead of checking request.fullpath != 'some_url', we can use something like ['x', 'y', 'z'].exclude? request.fullpath
    ## Also, if we encounter more than one "&&" in an if condition, we should create a method for the same.
    if current_path_useful?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    previous_or_root_path
  end

  def after_sign_out_path_for(resource)
    previous_or_root_path
  end

  def after_sign_up_path_for(resource)
    previous_or_root_path
  end
private
  ## fixed
  ## We can use this method in all the three methods above
  def previous_or_root_path
    session[:previous_url] || root_path
  end

  def current_path_useful?
    ['/users/sign_in', '/users/sign_up', '/users/sign_out'].exclude?(request.fullpath) &&
      !request.post? && # don't store post calls
      !request.xhr? # don't store ajax calls
  end

  def redirect_to_back_or_default_path
    if request.referer
      redirect_to :back
    else
      redirect_to resources_path
    end
  end

end
