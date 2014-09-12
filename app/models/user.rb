class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_uniqueness_of :email


  def login_attempt_counter
    self.update(logins: self.logins + 1)
  end

  def check_user_logins
    errors.add(:logins, "attempted too many times, wait 2 minutes ") if self.logins > 3
  end

  def erase_logins
    self.update(logins: 0)
  end

  def wait_2_minutes
    if Time.now - self.updated_at < 120
      login_attempt_counter
    else
      erase_logins
      login_attempt_counter
    end
  end



end
