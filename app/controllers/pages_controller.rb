class PagesController < ApplicationController
  def index
    redirect_to coffeecards_path if logged_in?
  end
end
