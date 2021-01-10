class UserSetting < ApplicationRecord
  belongs_to :group_user, optional: true
  has_many :user, through: :group_users
end
