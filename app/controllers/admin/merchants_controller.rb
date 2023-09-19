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
    merchant = Merchant.create({
      name: params[:name]
    })
    redirect_to "/admin/merchants"
  end

  def edit 
    @merchant = Merchant.find(params[:id])  
  end

  def update 
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      flash.alert = "Successfully Updated!"
      redirect_to "/admin/merchants/#{params[:id]}"
    else
      flash.alert = "Missing information"
      render 'edit'
    end
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end
end