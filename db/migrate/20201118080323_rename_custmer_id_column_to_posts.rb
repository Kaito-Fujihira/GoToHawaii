class RenameCustmerIdColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :custmer_id, :customer_id
  end
end
