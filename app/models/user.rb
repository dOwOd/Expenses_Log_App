class User < ApplicationRecord   
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :user_settings, through: :group_users

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true}

  # validates :screen_name, presence: true
  

  #:invite_tokenを追加。
  attr_accessor :remember_token, :activation_token, :reset_token, :invite_token

  #招待メールを送信する
  def send_invite_email
    UserMailer.invitation(self).deliver_now
  end

  #ユーザー招待の属性（トークンとダイジェストと、招待したユーザーのid）を作成する。
  def create_invite_digest
    self.invite_token = User.new_token
    update(invite_digest: User.digest(invite_token), invite_sent_at: Time.zone.now)
  end

  #招待の期限が切れている場合はtrueを返す
  def invitation_expired?
    self.invite_sent_at < 24.hours.ago
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if invite_digest.nil?
    BCrypt::Password.new(invite_digest).is_password?(remember_token)
  end

end
