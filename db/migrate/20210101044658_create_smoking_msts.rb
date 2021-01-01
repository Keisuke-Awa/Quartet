class CreateSmokingMsts < ActiveRecord::Migration[6.0]
  def change
    create_table :smoking_msts do |t|
      t.string :smoking_status

      t.timestamps
    end
  end
end
