class PasswordsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:notice] = 'E-mail sent with password reset instructions.'
    redirect_to login_path
  end

  def edit
    @user = User.find_by_reset_password_token!([params[:id]])
  end

  def update
    @user = User.find_by_reset_password_token!(params[:id])
    if @user.reset_password_sent_at < 2.hours.ago
      flash[:notice] = 'Password reset has expired'
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
