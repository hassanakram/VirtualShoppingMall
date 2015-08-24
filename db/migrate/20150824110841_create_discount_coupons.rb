class CreateDiscountCoupons < ActiveRecord::Migration
  def change
    create_table :discount_coupons do |t|
      t.string :coupen_number
      t.boolean :valid
      t.integer :discount_percentage

      t.timestamps
    end
  end
end
