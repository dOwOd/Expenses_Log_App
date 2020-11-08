class AddPaidAtToExpenses < ActiveRecord::Migration[6.0]
  def change
    execute 'DELETE FROM expenses';
    add_column :expenses, :paid_at, :datetime, null: false
  end
end
