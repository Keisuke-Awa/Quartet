class CreatePrefectureMsts < ActiveRecord::Migration[6.0]
  def change
    create_table :prefecture_msts do |t|
      t.string :prefecture_name, null: false

      t.timestamps
    end
  end
end
