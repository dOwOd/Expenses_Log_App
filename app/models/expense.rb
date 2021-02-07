class Expense < ApplicationRecord
  has_many :group_expenses, foreign_key: "expense_id", dependent: :destroy
  has_many :groups, through: :group_expenses
  belongs_to :users, optional: true

  accepts_nested_attributes_for :group_expenses, allow_destroy: true
  include FriendlyId
  friendly_id :friendly_url
  validates :friendly_url, length: { in: 0..8 },
                         uniqueness: true
end