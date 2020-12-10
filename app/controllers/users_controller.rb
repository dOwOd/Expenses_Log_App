class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_url(@user), notice: "ユーザー「#{@user.screen_name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
    @users = User.joins(:group_users).where(group_users: {group_id: session[:group_id]}).order("user_id ASC")
    logger.debug('@users.inspect ==========================================')
    logger.debug(@users.inspect)
    logger.debug(@current_group.inspect)
    logger.debug(session[:group_id])
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password, :password_confirmation)
  end
end
