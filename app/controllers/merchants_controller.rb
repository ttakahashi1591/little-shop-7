class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def items 
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end
end