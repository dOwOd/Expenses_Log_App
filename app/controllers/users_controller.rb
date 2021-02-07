class UsersController < ApplicationController
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
      char_list = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      friendly_url = (0...8).map { char_list[rand(char_list.length)] }.join
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
    # group = Groups.friendly.find_by(group_friendly_url: params[:group_friendly_url])
    group_users = GroupUser.find_by(group_id: params[:group_id], user_id: user.id)
    group_users.destroy
    redirect_to groups_url, notice: 'グループから抜けました。'
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password, :password_confirmation)
  end
end
