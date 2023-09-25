class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.bulk_discounts.create(discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:alert] = "Error: #{error_message(discount.errors)}"
      render 'new'
    end
    
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find(params[:id])
    if bulk_discount.can_be_modified?
      bulk_discount.delete
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:alert] = "Error: this discount can't be modified or deleted while there are pending invoices"
      redirect_to merchant_bulk_discounts_path(@merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(discount_params)
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}"  
    else
      flash[:alert] = "Error: #{error_message(@bulk_discount.errors)}"
      render 'edit'
    end
    
  end

  private

  def discount_params
    params.require(:bulk_discount).permit(:discount, :threshold)
  end
end