class RenamePostColumnToSpots < ActiveRecord::Migration[5.2]
  def change
    rename_column :spots, :post, :post_id
  end
end
