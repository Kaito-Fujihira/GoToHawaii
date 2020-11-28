class AddProfileImageIdToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :ProfileImageId, :string
  end
end
