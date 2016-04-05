class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private

  def user_signed?
    !current_user.nil?
  end

  def access_denied
    redirect_to root_path, notice: "To access this page You must be logged in"
  end

  def authorize!
    access_denied unless user_signed?
  end
end
