class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
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

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and articles deleted, sad to see you go!"
    redirect_to root_path
  end

  private

  def user_whitelist
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "Wait a minuite, this is not your profile! Get outta here!"
      redirect_to @user
    end
  end

end