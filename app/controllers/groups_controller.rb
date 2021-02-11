class GroupsController < ApplicationController
  include GroupsHelper
  skip_before_action :join_required, only: [:index, :new, :create]

  def index
    session[:group_id] = nil
    @groups = Group.joins(:group_users).where(group_users: {user_id: current_user.id}).order("group_id ASC")
    @search_date = Date.today.beginning_of_month
    @members = GroupUser.where(group_id: @groups.ids)
  end
  
  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    group = Group.new(group_params)

    friendly_url = ''
    # 重複のないfriendly_urlを生成するまでループ
    loop do
      char_list = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      friendly_url = (0...8).map { char_list[rand(char_list.length)] }.join
      if Group.friendly.find_by(friendly_url: friendly_url) == nil
        break
      end
    end
    group.friendly_url = friendly_url

    if group.save
      join_group group
      @user_setting = UserSetting.new
      @user_setting.group_user_id = group.group_users[0].id
      @user_setting.percentage_of_expenses = 100
      if @user_setting.save
        redirect_to groups_url, notice: "グループ「#{group.name}」を作成しました。"
      else
        render :new
      end 
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  def show
    @groups = Groups.find(params[:id])
  end 

  def destroy
    group = Group.find(params[:id])
    group.destroy
    session[:group_id] = nil
    redirect_to groups_url, notice: "グループ「#{group.name}」を削除しました。"
  end 

  private
  def group_params
    params.permit(:name, user_ids: [] )
  end

  def set_group
    @group = Group.find(params[:id])
  end

end