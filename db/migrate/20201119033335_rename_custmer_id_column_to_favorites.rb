class RenameCustmerIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :custmer_id, :customer_id
  end
end
