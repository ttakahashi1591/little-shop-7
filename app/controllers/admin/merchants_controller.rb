class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if !merchant.save
      flash.now[:alert] = "Please Input a Name"
      render :new
    else
      redirect_to "/admin/merchants"
    end
  end

  def edit 
    @merchant = Merchant.find(params[:id])  
  end

  def update 
    @merchant = Merchant.find(params[:id])
  
    if !@merchant.update(merchant_params)
      flash.alert = "Missing information"
      render 'edit'
    elsif params[:status] == "enabled"
      flash.alert = "Merchant is now enabled."
      redirect_to "/admin/merchants"
    elsif params[:status] == "disabled"
      flash.alert = "Merchant is now disabled."
      redirect_to "/admin/merchants"
    else
      flash.alert = "Successfully Updated!"
      redirect_to "/admin/merchants/#{params[:id]}"
    end
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end
end