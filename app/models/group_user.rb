class GroupUser < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user, optional: true
  has_one :user_setting, foreign_key: 'group_user_id'
end
