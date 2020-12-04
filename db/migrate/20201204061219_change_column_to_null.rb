class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :spots, :address, true
    change_column_null :spots, :latitude, true
    change_column_null :spots, :longitude, true
    change_column_null :spots, :post_id, true
  end

  def down
    change_column_null :spots, :address, false
    change_column_null :spots, :latitude, false
    change_column_null :spots, :longitude, false
    change_column_null :spots, :post_id, false
  end
end
