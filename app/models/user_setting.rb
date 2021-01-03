class UserSetting < ApplicationRecord
  belongs_to :group
  belongs_to :group_users, foreign_key: [:groups_users_id]
  has_many :user, through: :group_users
end
