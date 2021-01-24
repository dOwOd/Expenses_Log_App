class AddIsUsedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_used, :boolean
  end
end
