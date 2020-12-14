class InvitationsController < ApplicationController
  include SessionsHelper
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create

    if params[:invitee][:email].blank?
      redirect_to new_invitation_url, notice: "メールアドレスを入力してください。"
    elsif User.find_by(email: params[:invitee][:email])
      redirect_to new_invitation_url, notice: "そのメールアドレスはすでに招待済みです。"
    else
      @invite_user = User.create(screen_name: "名無しの招待者", email: params[:invitee][:email].downcase, password: "foobar", invited_by: current_group.id)
      @invite_user.create_invite_digest
      @invite_user.send_invite_email
      redirect_to root_url, notice: "招待メールを送信しました！"
    end
  end

  def edit
    @invite_user.screen_name = nil if @invite_user
  end

  def update
    if params[:user][:password].empty?
      @invite_user.errors.add(:password, :blank)
      render 'edit'
    elsif @invite_user.update_attributes(user_params)
      log_in @invite_user
      inviter = Group.find(@invite_user.invited_by)
      @group_users = GroupUser.new
      @group_users.group_id = params['user'][:group_id]
      @group_users.user_id = params['user'][:user_id]
      if @group_users.save
        flash[:success] = "ようこそ01Booksへ!"
        redirect_to @invite_user
      else
        render 'edit'
      end
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:screen_name, :password, :password_confirmation)
  end


  #beforeフィルタ

  def get_user
    @invite_user = User.find_by(email: params[:email])
  end

  #正しいユーザーかどうか確認する
  def valid_user
    unless (@invite_user && @invite_user.authenticated?(params[:id])) #params[:id]はメールアドレスに仕込まれたトークン
      flash[:danger] = "無効なリンクです。"
      redirect_to root_url
    end
  end

  #トークンが期限切れかどうか確認する
  def check_expiration
    if @invite_user.invitation_expired?
      flash[:danger] = "招待メールの有効期限が切れています。"
      redirect_to root_url
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end

end