class RenameExpensesColumnToExpenses < ActiveRecord::Migration[6.0]
  def change
    rename_column :expenses, :expenses, :expense
  end
end
