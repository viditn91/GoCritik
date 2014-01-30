class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :store_location
  before_action :set_locale
  helper_method :get_searchable_fields, :previous_or_root_path, :current_user

private

  def store_location
    # store location - this is needed for post-login/logout or post-signup redirect to whatever the user last visited.
    if current_path_useful?
      session[:previous_url] = request.fullpath
    end
  end

  def set_locale
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:error] = "#{params[:locale]} translation not available"
      end
    end
  end
  
  def default_url_options
    { locale: I18n.locale }
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

  def previous_or_root_path
    session[:previous_url] || root_path
  end

  def current_path_useful?
    request_path = params[:locale] ? request.fullpath.sub(/\/[\w]+/, '') : request.fullpath
    ['/users/sign_in', '/users/sign_up', '/users/sign_out'].exclude?(request_path) &&
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

  def get_searchable_fields
    Field.searchable.pluck(:name).prepend('name').map(&:downcase)
  end

  def authorize_user
    api_key = request.headers['HTTP_APP_KEY']
    unless api_key && api_key_genuine?(api_key)
      authenticate_user!
    end
  end

# overiding verified_request? to jump across the authentication token for json requests
# from other application 
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end
  
# overiding devise current_user method for setting user via api_key
  alias_method :devise_current_user, :current_user
  def current_user
    api_key = request.headers['HTTP_APP_KEY']
    if api_key
      User.find_by(api_key: api_key)
    else
      devise_current_user
    end
  end

  def api_key_genuine?(key)
    User.find_by(api_key: key).present?
  end
end
