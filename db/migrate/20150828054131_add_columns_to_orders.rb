class AddColumnsToOrders < ActiveRecord::Migration
  def up
    add_column :orders, :order_status, :string
    add_column :orders, :amount,       :string
  end

  def down
    remove_column :orders, :order_status
    remove_column :orders, :amount
  end
end
