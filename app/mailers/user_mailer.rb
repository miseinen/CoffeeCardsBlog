class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: t('registration_confirmation.mail.subject'))
  end

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: t('reset_password.recovery'))
  end
end
