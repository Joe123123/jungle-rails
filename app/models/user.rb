# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password

  has_many :orders

  validates :first_name, :last_name, :email, :password_digest, presence: true
end
