class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit 
    @merchant = Merchant.find(params[:id])  
  end

  def update 
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      if params[:name] != nil
        flash.alert = "Successfully Updated!"
      elsif params[:status] != nil
        if params[:status] = 1
          flash.alert = "Merchant is now enabled."
        else 
          flash.alert = "Merchant is now disabled."
        end
      else
        render 'edit'
      end
      redirect_to "/admin/merchants/#{params[:id]}"
    end
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end
end