class UsersController < ApplicationController
  before_action :login_required, except: [:new, :create]
  before_action :join_required, except: [:new, :create]

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
    @users = User.joins(:group_users).where(group_users: {group_id: current_group.id}).order("user_id ASC")
  end

  def destroy
    group_users = GroupUser.find_by(group_id: params[:group_id], user_id: params[:user_id])
    group_users.destroy
    redirect_to groups_url, notice: 'グループから抜けました。'
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password, :password_confirmation)
  end
end
