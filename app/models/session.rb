class Session < ActiveRecord::Base



  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate
      @user.erase_logins
    else
      if @user.logins == 0
        @user.login_attempt_counter
      else
        @user.wait_2_minutes
        render :new
      end
    end
  end

end
