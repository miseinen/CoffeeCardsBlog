class CoffeecardsController < ApplicationController
  before_action :set_coffeecard, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]

  PER_PAGE = 2

  def index
    locale = I18n.locale.to_s
    @coffeecards = Coffeecard.where(text_lang: locale)
    @coffeecards = @coffeecards.paginate(page: params[:page],
                                         per_page: PER_PAGE)
                               .order('created_at DESC')
  end

  def show; end

  def new
    @coffeecard = current_user.coffeecards.build
  end

  def edit; end

  def create
    @coffeecard = current_user.coffeecards.build(coffeecard_params)
    if @coffeecard.save
      flash[:notice] = t('coffeecards.create_success', title: @coffeecard.title)
      redirect_to coffeecards_path
    else
      render 'new'
    end
  end

  def update
    if @coffeecard.update(coffeecard_params)
      flash[:notice] = t('coffeecards.update_success', title: @coffeecard.title)
      redirect_to coffeecards_path
    else
      render 'edit'
    end
  end

  def destroy
    @coffeecard.destroy
    flash[:notice] = t('coffeecards.destroy_success', title: @coffeecard.title)
    redirect_to user_path(current_user)
  end

  private

    def set_coffeecard
      @coffeecard = Coffeecard.find(params[:id])
    end

    def coffeecard_params
      params.require(:coffeecard).permit(:title, :description, :text_lang)
    end
end
