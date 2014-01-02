class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  def show
  end

  def edit
  end

private
  def set_user
    user = User.find_by(id: params[:id])
    user ? @user = user : redirect_to(resources_path, notice: "User not found") 
  end
end