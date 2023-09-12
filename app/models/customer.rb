class Customer < ApplicationRecord
  has_many :invoices
  has_many :items, through: :invoices
end