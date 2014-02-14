class SessionsController < Devise::SessionsController

  def create
  	super
    flash[:notice] = nil
  end

end