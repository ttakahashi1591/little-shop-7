class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update 
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.status == "enabled"
      flash.alert = "Merchant is now enabled."
    else 
      flash.alert = "Merchant is now disabled."
    end
    redirect_to "/admin/merchants"
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end
end       
