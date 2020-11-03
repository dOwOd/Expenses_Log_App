class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.int :expenses
      t.text :description

      t.timestamps
    end
  end
end
