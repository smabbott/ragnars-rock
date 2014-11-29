class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_user #:authenticate_user! #


  def require_user
    # allow access to our authorization controller or callbacks fail
    whitelist = %w(devise/sessions omniauth_callbacks)
    return if whitelist.include? params[:controller]
    return redirect_to new_user_session_path unless current_user
  end

end
