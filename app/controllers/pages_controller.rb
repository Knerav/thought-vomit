class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
    @categories = Category.all
  end

  def about
  end
end
