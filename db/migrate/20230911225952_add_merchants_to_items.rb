class AddMerchantsToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :merchant, null: false, foreign_key: true
  end
end
