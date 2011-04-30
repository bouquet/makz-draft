class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :client_ip

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "yozloy" && password == "0054444944"
    end
  end

  def manage
    case action_name
    when "new", "edit"
      "manage"
    else
      "application"
    end
  end

  def client_ip
    request.remote_ip
  end
end
