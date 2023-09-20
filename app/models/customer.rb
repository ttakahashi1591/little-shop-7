class Customer < ApplicationRecord
  has_many :invoices
  has_many :items, through: :invoices
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def self.top
    select("customers.*, count(transactions.result) as transactions_count")
    .joins(:transactions).where("transactions.result = ?", 1)
    .group(:id)
    .order("transactions_count desc")
    .limit(5)
    # This will return the count of items in an invoice connected to a successful transaciton. Also can change count to a sum(invoice_items.quantity) to return total indivdual items. 
    # joins(invoices: :transactions)
    # .where("transactions.result = ?", 1)
    # .select("customers.*, count(distinct invoice_items.id) as item_count")
    # .joins(items: :invoice_items)
    # .group(:id)
    # .order("item_count desc")
    # .limit(5)
  end
end