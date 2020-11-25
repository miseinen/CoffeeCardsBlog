class UserMailer < ApplicationMailer
  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: t('reset_password.recovery'))
  end
end
