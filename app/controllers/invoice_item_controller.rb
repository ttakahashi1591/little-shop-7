class InvoiceItemController < ApplicationController 
  def create

  end

  def update
    InvoiceItem.find(params[:id]).update(invoice_item_params)
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status, :quantity, :unit_price)
  end
end