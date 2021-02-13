class UsersController < ApplicationController
  include ApplicationHelper
  before_action :login_required, except: [:new, :create]
  before_action :join_required, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    friendly_url = ''
    # 重複のないfriendly_urlを生成するまでループ
    loop do
      friendly_url = generate_friendly_url
      if Expense.friendly.find_by(friendly_url: friendly_url) == nil
        break
      end
    end
    @user.friendly_url = friendly_url

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
    user = User.friendly.find_by(friendly_url: params[:user_id])
    group = Group.friendly.find_by(friendly_url: params[:group_id])
    group_users = GroupUser.find_by(group_id: group.id, user_id: user.id)
    group_users.destroy
    redirect_to groups_url, notice: 'グループから抜けました。'
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password, :password_confirmation)
  end
end
