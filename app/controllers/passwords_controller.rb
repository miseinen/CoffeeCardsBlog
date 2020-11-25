class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:password][:email])
    if user
      user.send_password_reset 
      flash[:notice] = t('controller.password.email_sent')
      redirect_to login_path
    else
      flash[:notice] = t('controller.password.not_found')
      redirect_to login_path
    end
  end

  def edit
    @user = User.find_by_reset_password_token!([params[:id]])
  end

  def update
    @user = User.find_by_reset_password_token!(params[:id])
    if @user.reset_password_sent_at < 2.hours.ago
      flash[:notice] = t('controller.password.reset_expired')
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
