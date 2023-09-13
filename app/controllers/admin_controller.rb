class AdminController < ApplicationController
  def index
    @top_customers = Customer.top
  end
end