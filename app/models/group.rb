class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses
  belongs_to :user, optional: true
  
  include FriendlyId
  friendly_id :friendly_url
  validates :friendly_url, length: { in: 0..8 },
                         uniqueness: true
  validates :name, presence: true
end
