class Merchant < ApplicationRecord
  enum status: {
    disabled: 0,
    enabled: 1
  }
  
  validates_presence_of :name
  
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_5_customers
    invoices
      .joins(:transactions)
      .where('transactions.result = ?', 1)
      .select('customers.*, count(transactions.id) as success_count')
      .joins(:customer)
      .group('customers.id')
      .order('success_count desc')
      .limit(5)
  end

  def top_5_customers_sql
    Customer.find_by_sql(
      "select count(transactions.id), customers.* from transactions
      join invoices on invoices.id = transactions.invoice_id
      join customers on customers.id = invoices.customer_id
      join invoice_items on invoice_items.invoice_id = invoices.id
      join items on invoice_items.item_id = items.id
      where items.merchant_id = #{self.id}
      and transactions.result = 1
      group by customers.id
      order by count desc
      limit 5;"
    )
  end

  def items_ready_to_ship
    items
    .select('items.*, invoices.id as invoice_id')
    .joins(invoices: :transactions)
    .where('transactions.result = 1 and invoices.status in (1,2) and invoice_items.status = 1')
    .order('created_at')
  end

  def self.best_day(merchant)
    find_by_sql(
      "select invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue from invoice_items
        inner join invoices on invoices.id = invoice_items.invoice_id
        inner join items on items.id = invoice_items.item_id
        inner join merchants on merchants.id = items.merchant_id
        inner join transactions on invoices.id = transactions.invoice_id
      where merchants.id = #{merchant.id}
      and transactions.result = 1
      group by invoices.created_at
      order by revenue desc
      limit 1;"
    )
  end

  def best_day
    day = invoices.
          joins(:invoice_items)
          .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
          .group("invoices.created_at")
          .order('revenue desc')
          .first

    day.created_at.strftime("%A, %B %d, %Y")
  end

  def self.top_5
    joins(invoices: :transactions)
    .where('transactions.result = ?', 1)
    .select('merchants.*, sum((invoice_items.quantity * invoice_items.unit_price)/100) as revenue')
    .group('merchants.id')
    .order('revenue desc')
    .limit(5)
  end
end