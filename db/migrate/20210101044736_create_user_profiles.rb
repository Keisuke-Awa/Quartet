class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :height
      t.string :weight
      t.string :blood_type
      t.references :birthplace, foreign_key: { to_table: :prefecture_msts }
      t.references :occupation, foreign_key: { to_table: :occupation_msts }
      t.references :educational_bg, foreign_key: { to_table: :educational_bg_msts }
      t.references :annual_income, foreign_key: { to_table: :annual_income_msts }
      t.references :smoking_status, foreign_key: { to_table: :smoking_msts }

      t.timestamps
    end
  end
end
