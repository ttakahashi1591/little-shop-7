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

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    @item = @merchant.items.build(item_params)

    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      render :new
    end
  end

  private
  
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end