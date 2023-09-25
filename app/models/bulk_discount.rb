class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant

  validates :threshold, numericality: { only_integer: true }
  validates :discount, numericality: { only_integer: true }
  
  def can_be_modified?
    no_modify_array = BulkDiscount.find_by_sql(
      "select bulk_discounts.id from bulk_discounts
        inner join merchants on merchants.id = bulk_discounts.merchant_id
        inner join items on items.merchant_id = merchants.id
        inner join invoice_items on invoice_items.item_id = items.id
        inner join invoices on invoices.id = invoice_items.invoice_id
      where invoices.status = 2
      and invoice_items.quantity >= bulk_discounts.threshold
      group by bulk_discounts.id;"
    ).pluck('id')

    no_modify_array.include?(self.id) ? false : true
  end
end