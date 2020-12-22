class AddPrefectureIdToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :prefecture, null: false, foreign_key: { to_table: :prefecture_msts }
  end
end
