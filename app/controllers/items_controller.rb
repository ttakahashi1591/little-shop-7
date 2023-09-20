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
      flash[:alert] = "Fill in all fields."
      render 'edit'
    end
  end

  private
  
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end