class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :customers

  def top_5_customers
    # customers
    #   .joins(invoices: :transactions)
    #   .where('transactions.result = ?', 1)
    #   .group('customers.id')
    #   .order(count: :desc)
    #   .limit(5)
    customers
      .select('distinct customers.*, count(distinct transactions.id)')
      .joins(invoices: :transactions)
      .where("transactions.result = ?", 1)
      .group('customers.id')
      .order('count desc')
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
    invoices.joins(:transactions).where('transactions.result = ?', 1).where('invoices.status = ?', 2)
  end
end


# merchant1.customers.select('customers.*, count(transactions.id) as transactions').joins(:transactions).where(transactions: { result: "success" }).group(:
  # id).order('transactions desc')