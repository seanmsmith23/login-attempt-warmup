class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_params)
    if @user.save
      redirect_to root_path
    else
        render :new
      end
    end



  private
  def allowed_params
    params.require(:user).permit(:email, :password)
  end


end


# example
