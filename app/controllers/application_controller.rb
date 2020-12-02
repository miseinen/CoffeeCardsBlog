class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  around_action :switch_locale

  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = t('application.must_be_logged_in')
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @coffeecard.user && !current_user.admin?
      redirect_to @coffeecard 
    end
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def url_options
    { locale: I18n.locale }.merge(super)
  end
end
