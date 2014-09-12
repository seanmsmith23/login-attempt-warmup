class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    counter = 0
     @user = User.new(allowed_params)
      if @user.save
        redirect_to root_path
      elsif
        counter >= 5
        render :new
      else
        flash[:notice] = "You're doing that too much. Try again in 1 minutes"
        sleep(1.minutes)
        counter - 5
        render :new
      end
  end





 private
  def allowed_params
    params.require(:users).permit(:email, :password)
  end


end
