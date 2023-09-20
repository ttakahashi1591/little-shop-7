class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end
end       
