class CreateUserSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_settings do |t|
      t.integer :groups_users_id
      t.integer :percentage_of_expenses

      t.timestamps
    end
  end
end
