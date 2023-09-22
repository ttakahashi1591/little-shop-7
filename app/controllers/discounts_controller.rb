class DiscountsController < ApplicationController 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show 
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.build(discount_params)

    if @discount.save
      redirect_to "/merchants/#{@merchant.id}/discounts"
    else
      flash[:alert] = "Fill in all fields."
      render :new
    end
  end

  private
  
  def discount_params
    params.permit(:percent, :quantity_threshold)
  end
end
