class GroupsController < ApplicationController
  include GroupsHelper
  skip_before_action :join_required, only: [:index, :new, :create]

  def index
    @groups = Group.joins(:group_users).where(group_users: {user_id: current_user.id}).order("group_id ASC")
    if @groups == []
      redirect_to new_group_path
    end
  end
  
  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    group = Group.new(group_params)
    if group.save
      join_group group
      @user_setting = UserSetting.new
      @user_setting.groups_users_id = group.group_users[0].id
      @user_setting.percentage_of_expenses = 100
      if @user_setting.save
        redirect_to root_path, notice: "グループ「」を作成しました。"
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

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end

  def set_group
    @group = Group.find(params[:id])
  end

end