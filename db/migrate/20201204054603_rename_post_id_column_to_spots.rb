class RenamePostIdColumnToSpots < ActiveRecord::Migration[5.2]
  def change
    rename_column :spots, :post_id_id, :post
  end
end
