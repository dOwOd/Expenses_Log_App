class AddFriendlyUrlToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :friendly_url, :string

    add_index :groups, :friendly_url, :unique => true
  end
end
