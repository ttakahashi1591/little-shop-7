class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.find_invoice_items(@invoice)
  end
end