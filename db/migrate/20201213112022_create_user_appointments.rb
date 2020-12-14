class CreateUserAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
