class Merchant < ApplicationRecord
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
end