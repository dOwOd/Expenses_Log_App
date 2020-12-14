class UserMailer < ApplicationMailer

  def invitation(user)
    @invite_user = user
    @inviter = Group.find(@invite_user.invited_by)
    mail to: @invite_user.email, subject: "#{@inviter.name}が01Booksに招待しています。"
  end

end