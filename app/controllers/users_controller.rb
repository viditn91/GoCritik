class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :verify_user, only: :edit

  def show
    @review_keywords_template = Template.find_by(controller: 'users', action: 'show', view_element: 'review keywords')
    @rating_keywords_template = Template.find_by(controller: 'users', action: 'show', view_element: 'rating keywords')
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully"
    else
      render action: 'edit'
    end
  end

private
  def verify_user
    if !current_user || current_user != @user
      redirect_to user_path(@user)
    end
  end

  def set_user
    @user = User.find_by(id: params[:id])
    ## fixed
    ## Same as described in comments_controller
    unless @user
      flash[:error] = "User Not Found"
      redirect_to_back_or_default_path
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end