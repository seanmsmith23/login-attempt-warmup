class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_uniqueness_of :email


  def login_attempt_counter
    session = Session.first
    session.update(logins: (session.logins + 1))
    self.update(logins: (self.logins + 1))
  end

  def check_user_logins
    if self.logins >= 3
      true
    else
      false
    end
  end

  def erase_logins
    self.update(logins: 0)
  end

  def wait_1_minute
    if (Time.now - Session.first.updated_at)/60 < 1
     login_attempt_counter
    else
      erase_logins
      login_attempt_counter
    end
  end

  def not_locked_out
    if self.logins >= 3 && (Time.now - User.first.updated_at)/60 < 5
      false
    else
      erase_logins
      true
    end
  end

end
