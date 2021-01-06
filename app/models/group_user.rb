class GroupUser < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user, optional: true
  belongs_to :user_settings, foreign_key: [:id], optional: true
end
