module SessionsHelper

def sign_in(user)
    # create a new token
    remember_token = User.new_remember_token 

    # place unencrypted token in browser cookies
    cookies.permanent[:remember_token] = remember_token 
    
    # Save token to Database
    user.update_attribute(:remember_token, User.encrypt(remember_token))
end

def signed_in?
	!current_user.nil?
end
    
def current_user=(user)
	# set current user to user.
	# self.current_user is converted to current_user=(..)
	@current_user = user
end

 # ||= sets @current_user instance variable to the user 
 # corresponding to remember_token
def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
end

def current_user?(user)
    user == current_user
  end

def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

# Forwarding users to intended destination
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location # puts requested URL in session variable under the key :return_to
    session[:return_to] = request.url if request.get?
  end
end
