class RenameColumnNameInDiscountCoupen < ActiveRecord::Migration
  def up
    rename_column :discount_coupons, :valid, :active
  end

  def down
    rename_column :discount_coupons, :active, :valid
  end
end
