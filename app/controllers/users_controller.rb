class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @article = @user.articles
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_whitelist)
      flash[:notice] = "Your account was updated successfully!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_whitelist)
    if @user.save
      flash[:notice] = "Welcome to ThoughtVomit, #{@user.username}! Account successfully created"
      redirect_to articles_path
    else
      render 'new'
    end 
  end

  private

  def user_whitelist
    params.require(:user).permit(:username, :email, :password)
  end
end