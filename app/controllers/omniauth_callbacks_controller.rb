class OmniauthCallbacksController < ApplicationController
  
  def google_oauth2

    @user = User.find_for_google_oauth2(request.env['omniauth.auth'], current_user)

    unless @user.present?
      flash[:notice] = 'Please login with your assigned email account.'
    else
      if @user.persisted?
        flash[:notice] = "Google login successful"
        sign_in_and_redirect @user, event: :authentication
        return
      else
        session['devise.google_data'] = request.env['omniauth.auth']
      end
    end
    
    flash[:warning] = 'User not found'
    @user = nil

    redirect_to '/'
  end

  def failure
    flash[:notice] = 'Please login with your assigned email account.'
    redirect_to new_user_session_path
  end

end
