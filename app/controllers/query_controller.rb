class QueryController < ApplicationController
  
  def home
    if params[:set_locale]
      I18n.locale = params[:set_locale]
    end
  end

end