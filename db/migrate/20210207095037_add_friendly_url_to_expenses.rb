class AddFriendlyUrlToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :friendly_url, :string

    add_index :expenses, :friendly_url, :unique => true
  end
end
