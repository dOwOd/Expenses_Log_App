class AddInvitationToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :invite_digest, :string
    add_column :users, :invited_by, :integer
    add_column :users, :invite_sent_at, :datetime
  end

  def down
    remove_column :users, :invite_digest, :string
    remove_column :users, :invited_by, :integer
    remove_column :users, :invite_sent_at, :datetime
  end
end
