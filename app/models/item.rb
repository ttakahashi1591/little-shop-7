class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def quantity(invoice)
    InvoiceItem.where(item_id: id, invoice_id: invoice).first.quantity
  end

  def status(invoice)
    InvoiceItem.where(item_id: id, invoice_id: invoice).first.status
  end

  def ordered_on_date
    Invoice.find(self.invoice_id).date_conversion
  end
end