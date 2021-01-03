class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :user_settings, foreign_key: [:id]
end
