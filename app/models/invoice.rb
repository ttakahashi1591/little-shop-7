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

  def revenue_with_discounts
    revenue = Invoice.find_by_sql(
      "select sum((x.quantity * x.unit_price)*(100 - x.discount)/100) as revenue from
        (
        select max(disc_table.bulk_disc) as discount, disc_table.id, disc_table.quantity, disc_table.unit_price from
          (
          select max(bulk_discounts.discount) as bulk_disc, invoice_items.* from items
            inner join invoice_items on invoice_items.item_id = items.id
            inner join invoices on invoice_items.invoice_id = invoices.id
            inner join merchants on merchants.id = items.merchant_id
            inner join bulk_discounts on bulk_discounts.merchant_id = merchants.id
          where invoice_items.quantity >= bulk_discounts.threshold
          and invoices.id = #{self.id}
          group by invoice_items.id
          union all
          select 0 as bulk_disc, invoice_items.* from items
            inner join invoice_items on invoice_items.item_id = items.id
            inner join invoices on invoice_items.invoice_id = invoices.id
            inner join merchants on merchants.id = items.merchant_id
            inner join bulk_discounts on bulk_discounts.merchant_id = merchants.id
          where invoice_items.quantity < bulk_discounts.threshold
          and invoices.id = #{self.id}
          group by invoice_items.id
          ) disc_table
        group by disc_table.id, disc_table.quantity, disc_table.unit_price
        ) x"
    ).first.revenue.to_f/100
    revenue == 0.0 ? self.total_revenue : revenue
  end
end