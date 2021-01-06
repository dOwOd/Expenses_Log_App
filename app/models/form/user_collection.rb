class Form::UserCollection < Form::Base
  attr_accessor :setting_users

  def initialize(group_users_id, attributes = {})
    super attributes
    self.setting_users = UserSetting.joins("INNER JOIN group_users ON group_users.id = user_settings.groups_users_id INNER JOIN users ON users.id = group_users.user_id").select("user_settings.*, users.*").where("user_settings.groups_users_id = ?", group_users_id).order("users.id ASC")
  end

  # 上でsuper attributesとしているので必要
  def users_attributes=(attributes)
    self.users = attributes.map { |_, v| UserSetting.new(v) }
  end

  def save
    binding.pry
    # 実際にやりたいことはこれだけ
    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    UserSetting.transaction do
      self.users.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end