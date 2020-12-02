class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        flash.now[:alert] = t('sessions.registration_not_confirmed')
        render "new"
      end
    else
      flash.now[:alert] = t('sessions.incorrect_data')
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('sessions.logout')
    redirect_to root_path
  end
end
