class AddInviterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :inviter, :integer
  end
end
