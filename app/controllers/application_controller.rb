class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    ## Instead of checking request.fullpath != 'some_url', we can use something like ['x', 'y', 'z'].exclude? request.fullpath
    ## Also, if we encounter more than one "&&" in an if condition, we should create a method for the same.
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/sign_out" &&
      !request.fullpath.include?("/pictures/code_image") &&
      !request.post? && # don't store post calls
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_up_path_for(resource)
    session[:previous_url] || root_path
  end

  # We can use this method in all the three methods above
  # def previous_or_root_path
  #   session[:previous_url] || root_path
  # end
end
