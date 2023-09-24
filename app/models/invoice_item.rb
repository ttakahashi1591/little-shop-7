class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {
    "pending" => 0,
    "packaged" => 1,
    "shipped" => 2
  }

  def find_item
    Item.find(self.item_id)
  end

  def self.find_invoice_items(invoice)
    all.where('invoice_id = ?', invoice.id)
  end

  def applied_discount
    discount = InvoiceItem.find_by_sql(
      "select invoice_items.*, bulk_discounts.id as bulk_disc_id from bulk_discounts
      inner join merchants on merchants.id = bulk_discounts.merchant_id
      inner join items on items.merchant_id = merchants.id
      inner join invoice_items on invoice_items.item_id = items.id
      inner join invoices on invoices.id = invoice_items.invoice_id
    where invoice_items.quantity >= bulk_discounts.threshold
    and invoice_items.id = #{self.id}
    order by threshold desc
    limit 1;"
    )
    discount.first.bulk_disc_id if !discount.empty? 
  end
end