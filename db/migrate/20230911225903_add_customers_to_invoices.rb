class AddCustomersToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :customer, null: false, foreign_key: true
  end
end
