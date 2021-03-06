class ArticlesController < ApplicationController
  before_action :article_setter, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(white_list)
    @article.user = current_user
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
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "Edit your own work, get outta here!"
      redirect_to @article
    end
  end

end