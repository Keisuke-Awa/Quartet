class AddPrefectureIdToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :prefecture, null: false, default: 13,  foreign_key: { to_table: :prefecture_msts }
    change_column_default :places, :prefecture, nil
  end
end
