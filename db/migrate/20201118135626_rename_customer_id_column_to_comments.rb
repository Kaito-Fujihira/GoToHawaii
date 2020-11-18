class RenameCustomerIdColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :custmer_id, :customer_id
  end
end
