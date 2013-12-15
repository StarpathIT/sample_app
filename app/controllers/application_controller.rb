class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # We have to explicitly include the helper modules in controllers. Not the case in case of views.
  include SessionsHelper 
end
