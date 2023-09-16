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
end