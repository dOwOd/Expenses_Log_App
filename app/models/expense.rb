class Expense < ApplicationRecord
  has_many :group_expenses
  has_many :groups, through: :group_expenses

  accepts_nested_attributes_for :group_expenses, allow_destroy: true
end
