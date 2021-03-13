class CreateNewArrivals < ActiveRecord::Migration[6.0]
  def change
    create_table :new_arrivals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :model
      t.bigint :record_id

      t.timestamps
    end
  end
end
