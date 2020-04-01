# frozen_string_literal: true

class Admin::DashboardController < ApplicationController
  def show
    @products = Product.all
    @categories = Category.all
  end
end
