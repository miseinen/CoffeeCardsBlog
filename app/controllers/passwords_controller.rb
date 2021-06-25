class PasswordsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:password][:email])
    if user
      user.send_password_reset
      flash[:notice] = t('passwords.recovery_mail_sent')
    else
      flash[:notice] = t('passwords.user_not_found')
    end
    redirect_to login_path
  end

  def edit
    @user = User.find(id: params[:id])
  end

  def update
    @user = User.find(id: params[:id])
    if @user.reset_password_sent_at < 2.hours.ago
      flash[:notice] = t('passwords.reset_expired')
      redirect_to new_password_path
    elsif @user.update(user_params)
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password)
    end
end
