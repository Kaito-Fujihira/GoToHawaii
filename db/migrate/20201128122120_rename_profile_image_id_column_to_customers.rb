class RenameProfileImageIdColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :ProfileImageId, :profile_image_id
  end
end
