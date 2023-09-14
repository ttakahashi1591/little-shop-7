class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: {
    "cancelled" => 0,
    "completed" => 1,
    "in progress" => 2
  }

  def self.not_shipped
    select("invoices.id, invoices.created_at").joins(:invoice_items).where("invoice_items.status != ?", 2).order("created_at asc")
  end

  def date_conversion
    created_at.strftime("%A, %B %d, %Y")
  end
end