class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :login_required
  skip_before_action :join_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to groups_url, notice: 'ログインしました。'
    elsif user == nil
      flash[:login_alert] = 'メールアドレスが違います。'
      redirect_to root_url
    else
      flash[:login_alert] = 'メールアドレスまたはパスワードが違います。'
      redirect_to root_url
    end
  end

  def destroy 
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end 
end
