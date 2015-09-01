class AddColumnToProduct < ActiveRecord::Migration
  def up
    add_column :products, :delta, :boolean, default: true, null: false
  end

  def down
    remove_column :products, :delta
  end
end
