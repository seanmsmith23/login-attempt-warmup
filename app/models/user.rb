class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validate :check_user_logins

  def login_attempt_counter
    self.logins += 1
  end

  def check_user_logins
   errors.add(:logins, "attempted too many times, wait 5 minutes ") if self.logins < 5
  end

  def erase_logins
    self.logins = 0
  end

  def wait_2_minutes
    if Time.now - self.updated_at < 2.minutes
      login_attempt_counter
    else
      erase_logins
    end
  end

end
