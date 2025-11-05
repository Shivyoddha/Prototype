class AdminController < ApplicationController
  skip_before_action :authenticate_user, only: []
  
  def index
    @users = User.all.order(:user_name)
  end
  
  def edit_user
    @user = User.find(params[:id])
  end
  
  def update_user
    @user = User.find(params[:id])
    
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_params)
      redirect_to admin_index_path, notice: "User #{@user.user_name} updated successfully!"
    else
      render :edit_user
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
  end
end

