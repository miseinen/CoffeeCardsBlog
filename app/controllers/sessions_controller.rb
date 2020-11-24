class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(I18n.locale, user)
    else
      flash.now[:alert] = t('controller.session.alert.incorrect')
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('controller.session.notice.logout')
    redirect_to root_path
  end
end
