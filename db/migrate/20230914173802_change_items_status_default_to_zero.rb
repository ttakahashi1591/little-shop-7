class ChangeItemsStatusDefaultToZero < ActiveRecord::Migration[7.0]
  def change
    change_column_default :items, :status, 0
  end
end
