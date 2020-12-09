class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_group
  before_action :login_required

  private

  def current_user
    logger.debug('in current_user -------------------------------------------------------')
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # logger.debugk(@current_user)
    # logger.debug(@current_user.inspect)
  end

  def current_group
    logger.debug('in current_group -------------------------------------------------------')
    @current_group = session[:group_id]
    # logger.debug(@current_group)
  end

  def login_required
    redirect_to login_url unless current_user
  end 
end
