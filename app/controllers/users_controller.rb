class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :verify_user, only: :edit

  def show
    @location_field = Field.find_by_name(:Location)
    @city_field = Field.find_by_name(:City)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully"
    end
  end

private
  def verify_user
    if !current_user || current_user != @user
      redirect_to user_path(@user)
    end
  end

  def set_user
    user = User.find_by(id: params[:id])
    ## Same as described in comments_controller
    user ? @user = user : redirect_to(resources_path, notice: "User not found")
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end