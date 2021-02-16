class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_group
  before_action :login_required
  before_action :join_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_group
    if session[:group_id] != nil
      @current_group = Group.friendly.find_by(friendly_url: session[:group_id])
    else
      @current_group = Group.friendly.find_by(friendly_url: params[:group_id])
    end
  end

  def login_required
    redirect_to login_url unless current_user
  end 

  def join_required
    redirect_to groups_url unless current_group
  end 
end
