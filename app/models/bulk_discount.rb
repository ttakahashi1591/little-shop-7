class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant

  def to_percent
    (100 - self.discount)/100.to_f
  end
end