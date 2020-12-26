class UserMailer < ApplicationMailer

  def invitation(user)
    @invite_user = user
    @inviter = Group.joins(:group_users).joins(:users).select("groups.*, users.*").where(group_users: {group_id: @invite_user.invited_by}, users: {id: @invite_user.inviter}).first
    mail to: @invite_user.email, subject: "#{@inviter.name}への招待が届いています。"
  end

end