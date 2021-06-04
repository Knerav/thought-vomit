class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_whitelist)
      flash[:notice] = "Your account was updated successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_whitelist)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to ThoughtVomit, #{@user.username}! Account successfully created"
      redirect_to @user
    else
      render 'new'
    end 
  end

  private

  def user_whitelist
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end