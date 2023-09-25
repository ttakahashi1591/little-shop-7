class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant

  validates :threshold, numericality: { only_integer: true }
  validates :discount, numericality: { only_integer: true }
end