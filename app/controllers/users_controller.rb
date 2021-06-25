class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  PER_PAGE = 2

  def index
    @users = User.paginate(page: params[:page],
                           per_page: PER_PAGE)
                 .where(email_confirmed: true)
                 .order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def edit; end

  def show
    @coffeecards = @user.coffeecards
    @coffeecards = @coffeecards.paginate(page: params[:page],
                                         per_page: PER_PAGE)
                               .order('created_at DESC')
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = t('users.confirmation_mail_sent')
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('users.update_success')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('users.delete_success')
    if @user == current_user
      session[:user_id] = nil
      redirect_to login_path
    else
      redirect_to users_path
    end
  end

  def confirm_email
    user = User.find_by!(params[:id])
    return unless user

    user.email_activate
    flash[:notice] = t('users.create_success', username: user.username)
    session[:user_id] = nil
    redirect_to login_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :about, :email, :password,
                                   :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      redirect_to @user if current_user != @user && !current_user.admin?
    end
end
