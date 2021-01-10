class UserSettingsController < ApplicationController
  def create
    # 処理が冗長的過ぎる気がする，，，
    group_user_ids = []
    user_settings_percentage_of_expenses = []
    @user_setting = []

    group_user_ids = group_user_ids_params[:group_user_id]
    user_settings_percentage_of_expenses = user_settings_percentage_of_expenses_params[:percentage_of_expenses]

    user_settings_percentage_of_expenses.map!(&:to_i)
    if user_settings_percentage_of_expenses.sum == 100
      group_user_ids.each_with_index do |group_user_id, i|
        @user_setting << UserSetting.find_by(group_user_id: group_user_id)
        @user_setting[i].percentage_of_expenses = user_settings_percentage_of_expenses[group_user_ids.index(group_user_id)]
        @user_setting[i].save!
      end
      redirect_to expenses_url, notice: '設定を更新しました。'
    else
      flash[:setting_alert] = '割合の合計を100%にしてください。'
      redirect_to expenses_url
    end
    
  end 

  private

  def group_user_ids_params
    params.require(:user_settings).permit(group_user_id: [])
  end 

  def user_settings_percentage_of_expenses_params
    params.require(:user_settings).permit(percentage_of_expenses: [])
  end
end
 