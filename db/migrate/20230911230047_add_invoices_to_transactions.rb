class AddInvoicesToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :invoice, null: false, foreign_key: true
  end
end
