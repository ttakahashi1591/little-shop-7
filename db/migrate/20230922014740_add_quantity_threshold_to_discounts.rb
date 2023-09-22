class AddQuantityThresholdToDiscounts < ActiveRecord::Migration[7.0]
  def change
    add_column :discounts, :quantity_threshold, :integer
  end
end
