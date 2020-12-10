class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_group
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_group
    @current_group = Group.find_by(id: session[:group_id])
  end

  def login_required
    redirect_to login_url unless current_user
  end 
end
