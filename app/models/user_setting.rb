class UserSetting < ApplicationRecord
  belongs_to :group,  optional: true
  belongs_to :group_users, foreign_key: [:groups_users_id],  optional: true
  has_many :user, through: :group_users
end
