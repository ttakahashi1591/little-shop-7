class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def top_5_customers
    customers
      .joins(invoices: :transactions)
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .order(count: :desc)
      .limit(5)
  end

  def invoices_in_progress
    invoices.where(status: 2).joins(:transactions).where(result: 1)
  end
end