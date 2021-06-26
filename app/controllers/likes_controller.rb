class LikesController < ApplicationController
  before_action :find_coffeecard
  before_action :find_like, only: [:destroy]

  def create
    return if already_liked?

    @coffeecard.likes.create(user_id: current_user.id)
    redirect_to coffeecard_path(@coffeecard)
  end

  def destroy
    return unless already_liked?

    @like.destroy
    redirect_to coffeecard_path(@coffeecard)
  end

  private

    def find_coffeecard
      @coffeecard = Coffeecard.find(params[:coffeecard_id])
    end

    def already_liked?
      Like.where(user_id: current_user.id,
                   coffeecard_id: params[:coffeecard_id]).exists?
    end

    def find_like
      @like = @coffeecard.likes.find(params[:id])
    end
end
