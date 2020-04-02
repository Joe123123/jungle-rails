# frozen_string_literal: true

module SessionHelper
  def in_user_session?
    session[:user_email].present?
  end
end
