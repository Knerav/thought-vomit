class UsersController < ApplicationController
  def new
    @user = User.new
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