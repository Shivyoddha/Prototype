class ApplicationController < ActionController::Base
  before_action :authenticate_user
  before_action :check_admin_access, if: :admin_route?
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    unless current_user
      redirect_to login_path
    end
  end
  
  def admin_route?
    request.path.start_with?('/admin')
  end
  
  def check_admin_access
    unless current_user&.admin?
      redirect_to dashboard_path, alert: 'Access denied. Admin privileges required.'
    end
  end

  helper_method :current_user
end

