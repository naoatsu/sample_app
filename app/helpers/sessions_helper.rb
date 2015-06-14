module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token # (1)
    cookies.permanent[:remember_token] = remember_token # (2)
    user.update_attribute(:remember_token, User.encrypt(remember_token)) # (3)
    self.current_user = user # (4)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def sign_out
	  self.current_user = nil
    cookies.delete(:remember_token)
  end
end
