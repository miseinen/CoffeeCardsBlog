class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email,
         subject: t('user_mailer.registration_confirmation_subject'))
  end

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: t('user_mailer.forgot_password_subject'))
  end
end
