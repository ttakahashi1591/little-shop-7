class AddStatusToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :status, :integer, default: 0
  end
end
