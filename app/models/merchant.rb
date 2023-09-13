class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :customers

  def top_5_customers
    customers
      .joins(invoices: :transactions)
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .order(count: :desc)
      .limit(5)
  end

  def items_ready_to_ship
    invoices.joins(:transactions).where('transactions.result = ?', 1).where('invoices.status = ?', 2)
  end
end


# merchant1.customers.select('customers.*, count(transactions.id) as transactions').joins(:transactions).where(transactions: { result: "success" }).group(:
  # id).order('transactions desc')