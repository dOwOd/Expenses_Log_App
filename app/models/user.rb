class User < ApplicationRecord
  has_secure_password

  validates :screen_name, presence: true
  validates :email, presence: true, uniqueness: true
end
