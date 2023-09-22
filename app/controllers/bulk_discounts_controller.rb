class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
end