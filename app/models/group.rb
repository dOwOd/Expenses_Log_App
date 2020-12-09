class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_expenses
  has_many :expenses, through: :group_expenses
  
  validates :name, presence: true
end
