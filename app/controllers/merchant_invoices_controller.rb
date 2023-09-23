class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @discounts = Merchant.find(params[:merchant_id]).bulk_discounts
    @invoice_items = InvoiceItem.find_invoice_items(@invoice)
  end
end