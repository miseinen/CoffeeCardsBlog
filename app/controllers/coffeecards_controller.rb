class CoffeecardsController < ApplicationController
  before_action :set_coffeecard, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  PER_PAGE = 2

  def index
    @coffeecards = Coffeecard.paginate(page: params[:page], per_page: PER_PAGE).order("created_at DESC")
  end

  def show
  end

  def new
    @coffeecard = current_user.coffeecards.build
  end

  def edit
  end

  def create
    @coffeecard = current_user.coffeecards.build(coffeecard_params)
    if @coffeecard.save
      flash[:notice] = "CoffeeCard was created successfully."
      redirect_to @coffeecard
    else
      render "new"
    end
  end

  def update
    if @coffeecard.update(coffeecard_params)
      flash[:notice] = "CoffeeCard was updated successfully."
      redirect_to @coffeecard
    else
      render "edit"
    end
  end

  def destroy
    @coffeecard.destroy
    flash[:notice] = "CoffeeCard was deleted successfully."
    redirect_to current_user
  end

  private

  def set_coffeecard
    @coffeecard = Coffeecard.find(params[:id])
  end

  def coffeecard_params
    params.require(:coffeecard).permit(:title, :description)
  end
end
