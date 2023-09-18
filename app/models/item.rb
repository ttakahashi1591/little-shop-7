class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def quantity(invoice)
    InvoiceItem.where(item_id: id, invoice_id: invoice).first.quantity
  end

  def invoice_status(invoice)
    InvoiceItem.where(item_id: id, invoice_id: invoice).first.status
  end

  def ordered_on_date
    Invoice.find(self.invoice_id).date_conversion
  end

  def self.enabled
    where(status: :enabled)
  end

  def self.disabled
    where(status: :disabled)
  end

  def self.top_5_items
    joins(invoices: :transactions)
    .where('transactions.result = ?', 1) 
    .select('items.*, sum((invoice_items.quantity * invoice_items.unit_price)/100) as revenue')
    .group('items.id')
    .order('revenue desc')
    .limit(5)
  end
end