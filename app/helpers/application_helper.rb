module ApplicationHelper
  def get_maxlength(model, attribute)
    model.validators_on(attribute)
      .select { |v| v.class == ActiveRecord::Validations::LengthValidator }
      .select { |v| v.options[:maximum].present? }.first.options[:maximum]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
