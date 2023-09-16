class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.all.where('invoice_id = ?', @invoice.id)
  end
end