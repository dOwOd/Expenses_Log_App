class RemoveGroupsUsersIdFromUserSettings < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_settings, :groups_users_id, :integer
  end
end
group_user_ids