class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.find_invoice_items(@invoice)
    @merchant = Merchant.find(params[:merchant_id])
  end
end