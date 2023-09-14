class AdminController < ApplicationController
  def index
    @top_customers = Customer.top
    @invoices = Invoice.all
  end
end