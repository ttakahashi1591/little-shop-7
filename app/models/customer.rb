class Customer < ApplicationRecord
  has_many :invoices
  has_many :items, through: :invoices
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def self.top
    select("customers.*, count(transactions.result) as transactions_count").joins(:transactions).where("transactions.result = ?", 1).group(:id).order("transactions_count desc").limit(5)
  end
end