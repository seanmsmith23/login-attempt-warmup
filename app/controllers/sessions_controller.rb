class SessionsController < ApplicationController
  skip_before_action :ensure_current_user

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.password == params[:user][:password] && @user.not_locked_out
      session[:user_id] = @user.id
      @user.erase_logins
      p "You're Super smart"
      redirect_to root_path
    else
      if @user.logins == 0 && @user.logins < 3
        p "logins are 0"
        @user.login_attempt_counter
      else
        p "logins are more than 0"
        @user.wait_1_minute
      end

      if @user.check_user_logins
        redirect_to new_session_path, notice: "Too many login attempts. Try again in a few minutes"
      else
        redirect_to new_session_path, notice: "Incorrect password/user combo"
      end
    end
  end
end
