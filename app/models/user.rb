class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_uniqueness_of :email


  def login_attempt_counter
    #everytime there is a bad login attempt update the counter in the sessions database
  end

  def check_user_logins
   #when there is a bad attempt, check the sessions db to see if they have reached the maximum
  end

  def erase_logins
    self.update(logins: 0)
  end

  def wait_1_minute
    if
     # if the current time is less than 1 minute since the last bad attempt, update the counter again
    else
      erase_logins
      login_attempt_counter
    end
  end



end
