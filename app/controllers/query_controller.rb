class QueryController < ApplicationController
  
  def home
    if params[:set_locale]
      request_path = request.referer.sub(Regexp.new(I18n.locale.to_s), params[:set_locale].to_s)
      I18n.locale = params[:set_locale]
      redirect_to request_path
    end
  end

end