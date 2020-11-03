class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.string :name, limit: 30, null: false
      t.integer :expenses, limit: 3, null: false
      t.text :description, limit: 128

      t.timestamps
    end
  end
end
