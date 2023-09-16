class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    @enabled_items = @merchant.items.enabled
    @disabled_items = @merchant.items.disabled
  end

  def show 
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update({
      status: params[:status]
    })

    redirect_to "/merchants/#{@merchant.id}/items"
  end
end