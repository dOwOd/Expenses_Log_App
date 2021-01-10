class AddForeignKeyToTheForUserSettings < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_settings, :group_user, foreign_key: true
  end
end
