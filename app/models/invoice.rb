class Invoice < ApplicationRecord
  enum status: {
    "cancelled" => 0,
    "completed" => 1,
    "in progress" => 2
  }
end