class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @users = User.all.order(:user_name)
  end

  def create
    user = User.find_by(user_name: params[:user_name])
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'Successfully logged in!'
    else
      flash.now[:alert] = 'Invalid username or password'
      @users = User.all.order(:user_name)
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Successfully logged out!'
  end
end

