class ItemsController < ApplicationController

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:alert] = "Item successfully updated!"
      redirect_to "/items/#{@item.id}"
    else
      render 'edit'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new(item_params)

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