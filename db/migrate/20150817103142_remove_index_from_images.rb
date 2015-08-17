class RemoveIndexFromImages < ActiveRecord::Migration
  def change
    remove_index :images, [:imageable_type, :imageable_id]
  end
end
