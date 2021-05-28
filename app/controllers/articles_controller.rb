class ArticlesController < ApplicationController
  before_action :article_setter, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(white_list)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article saved successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(white_list)
      flash[:notice] = "Article updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_setter
    @article = Article.find(params[:id])
  end

  def white_list
    params.require(:article).permit(:title, :description)
  end
end