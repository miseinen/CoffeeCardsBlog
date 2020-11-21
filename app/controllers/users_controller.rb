class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  PER_PAGE = 2

  def index
    @users = User.paginate(page: params[:page], per_page: PER_PAGE).order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
    @articles = @user.articles
    @articles = @articles.paginate(page: params[:page], per_page: PER_PAGE).order("created_at DESC")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to CoffeeTime Blog, #{@user.username}. You have successfully signed up."
      redirect_to new_article_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was updated successfully."
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    current_user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account was deleted successfully."
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :about, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    redirect_to @user if current_user != @user
  end
end
