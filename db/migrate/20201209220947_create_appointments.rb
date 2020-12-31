class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :meeting, foreign_key: true, null: false
      t.references :planning_user, foreign_key: { to_table: :users} , null: false
      t.references :approved_user, foreign_key: { to_table: :users }, null: false
      t.references :message_room, foreign_key: true, null: false

      t.timestamps
    end
  end
end
