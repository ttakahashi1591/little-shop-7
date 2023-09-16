class InvoiceItemController < ApplicationController 
  def create

  end

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)
    # require 'pry'; binding.pry
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{invoice_item.invoice_id}"
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status, :quantity, :unit_price)
  end
end