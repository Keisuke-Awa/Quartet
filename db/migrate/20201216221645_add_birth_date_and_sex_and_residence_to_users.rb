class AddBirthDateAndSexAndResidenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birth_date, :date, null: false
    add_column :users, :sex, :string, null: false, limit: 1
    add_reference :users, :residence, null: false, foreign_key: { to_table: :prefecture_msts }
  end
end
