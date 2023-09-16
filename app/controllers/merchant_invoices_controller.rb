class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.all.where('invoice_id = ?', @invoice.id)
  end
end