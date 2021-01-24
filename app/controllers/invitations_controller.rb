class InvitationsController < ApplicationController
  include SessionsHelper
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  skip_before_action :login_required, only: [:edit, :update]
  skip_before_action :join_required, only: [:edit, :update]

  def new
  end

  def create
    if params[:invitee][:email].blank?
      redirect_to root_url, notice: "メールアドレスを入力してください。"

    elsif User.joins(:group_users).find_by(group_users: { group_id: current_group.id}, email: params[:invitee][:email]) != nil
      redirect_to new_invitation_url, notice: "そのメールアドレスはすでに招待済みです。"

    else
      # 既にアカウント作成済みの場合(update -> メール送信)
      if @invite_user = User.find_by(email: params[:invitee][:email])
        @invite_user.update(invited_by: current_group.id, inviter: current_user.id, is_used: true)
      # アカウント未作成の場合(create -> メール送信)
      else
        @invite_user = User.create(screen_name: "名無しの招待者", email: params[:invitee][:email].downcase, password: "foobar", invited_by: current_group.id, inviter: current_user.id, is_used: false)
      end
      
      @invite_user.create_invite_digest
      @invite_user.send_invite_email
      redirect_to root_url, notice: "招待メールを送信しました！"
    end
  end

  def edit
    if @invite_user.is_used
      #既存ユーザの場合
      params[:is_used] = @invite_user.is_used
      update
    else
      # 初期ユーザの場合
      @invite_user.screen_name = nil if @invite_user  
    end
  end

  def update
    if params[:is_used] # 既存ユーザの場合
      log_in @invite_user
      @group_users = GroupUser.new
      @group_users.group_id = @invite_user.invited_by
      @group_users.user_id = @invite_user.id
      @group_users.save!
      session[:group_id] = @group_users.group_id

      @user_setting = UserSetting.new
      @user_setting.group_user_id = @group_users.id
      @user_setting.percentage_of_expenses = 0
      @user_setting.save!

      @group = Group.find_by(id: @group_users.group_id)
      redirect_to root_url, notice: "#{@group.name}に参加しました。"
    else # 初期ユーザの場合
      if params[:user][:password].empty?
        @invite_user.errors.add(:password, :blank)
        render 'edit'
      elsif @invite_user.update(user_params)
        log_in @invite_user
        @group_users = GroupUser.new
        @group_users.group_id = params['user'][:group_id]
        @group_users.user_id = params['user'][:user_id]
        @group = Group.find_by(id: @group_users.group_id)
        if @group_users.save
          @user_setting = UserSetting.new
          @user_setting.group_user_id = @group_users.id
          @user_setting.percentage_of_expenses = 0

          if @user_setting.save
            session[:group_id] = @group_users.group_id
            redirect_to root_url, notice: "#{@group.name}に参加しました。"
          else
            render 'edit'  
          end
        else
          render 'edit'
        end
      else
        render 'edit'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:screen_name, :password, :password_confirmation, :is_used)
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