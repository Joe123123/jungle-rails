# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  has_many :orders

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { in: 6..20 }

  before_save :email_to_lowercase

  def self.authenticate_with_credentials(email, password)
    formatted_email = email.strip.downcase
    @user = User.find_by_email(formatted_email)
    @user if @user&.authenticate(password)
  end

  private

  def email_to_lowercase
    self.email = email.downcase
  end
end
