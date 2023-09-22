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
    select("invoices.id, invoices.created_at").joins(:invoice_items).where("invoice_items.status != ?", 2).order("created_at asc").distinct
  end

  def date_conversion
    created_at.strftime("%A, %B %d, %Y")
  end

  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')/100.00
  end

  def self.discounted_revenue(invoice)
    find_by_sql(
        "select sum(revenue) from
        (
        select sum(unit_price * quantity)/100.00 as revenue from invoices
          inner join invoice_items on invoices.id = invoice_items.invoice_id
          where invoices.id = #{invoice.id}
          and invoice_items.quantity < 10
          UNION ALL
            select (sum(unit_price * quantity)/100.00)*.80 as revenue from invoices
              inner join invoice_items on invoices.id = invoice_items.invoice_id
              where invoices.id = 5
              and invoice_items.quantity >= 10
        ) x"
      )
      .first
      .sum
  end
end