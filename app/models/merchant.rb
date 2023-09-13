class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :customers
end


# merchant1.customers.select('customers.*, count(transactions.id) as transactions').joins(:transactions).where(transactions: { result: "success" }).group(:
  # id).order('transactions desc')