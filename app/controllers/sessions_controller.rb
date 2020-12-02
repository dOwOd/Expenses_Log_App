class SessionsController < ApplicationController
  def new
    logger.debug('---------------------------------------------------------------------')
  end

  def create
    user = User.find(email: session_params[:email])
    logger.debug('---------------------------------------------------------------------')

    if user&authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'ログインしました。'
    else
      render :new
    end
  end
end
