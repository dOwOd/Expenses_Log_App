class UserSettingsController < ApplicationController
  def create
    @user_setting = UserSetting.find_by(groups_users_id: params[:form_user_collection][:groups_users_id])
    @user_setting.percentage_of_expenses = params[:form_user_collection][:percentage_of_expenses]
    @user_setting.save!
    redirect_to expenses_url, notice: '設定を更新しました。'
  end 

  private

  def user_setting_params
    params.require(:user_settings).permit(:groups_users_id)
  end 
end
 