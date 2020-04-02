# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_email(params['/login'][:email])
    # If the user exists AND the password entered is correct.
    if @user&.authenticate(params['/login'][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_email] = @user[:email]
      redirect_to :root
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to login_path
    end
  end

  def destroy
    session[:user_email] = nil
    redirect_to login_path
  end

  # private

  # def user_params
  #   params.permit(
  #     :email,
  #     :password
  #   )
  # end
end
